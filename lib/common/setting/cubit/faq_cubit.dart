import 'package:swoony/common/setting/cubit/faq_state.dart';
import 'package:swoony/common/setting/model/faq_model.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';

enum FaqType { venue, user }

class FaqCubit extends SafeCubit<FaqState> {
  FaqCubit({required this.faqType}) : super(const FaqState());
  final DioService _dioService = getIt();
  final FaqType faqType;

  void fetch({bool isRefresh = false}) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, page: isRefresh ? 1 : state.page));

    final result = await _dioService.request<List<FaqModel>>( 
      input: RequestInput(
        endpoint: faqType == FaqType.venue
            ? ApiEndPoint.instance.faqVenue
            : ApiEndPoint.instance.faqUser,
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) => (data as List).map((e) => FaqModel.fromMap(e)).toList(),
    );
    emit(
      state.copyWith(
        isLoading: false,
        page: state.page + 1,
        faq: isRefresh ? result.data : [...state.faq, ...result.data ?? []],
      ),
    );
    return;
  }
}
