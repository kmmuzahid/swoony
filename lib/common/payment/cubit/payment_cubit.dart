import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/payment/cubit/payment_state.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/main.dart';

class PaymentCubit extends SafeCubit<PaymentState> {
  PaymentCubit(this.authCubit) : super(PaymentState());

  final AuthCubit authCubit;
  final DioService _dioService = getIt();
  bool isLoading = false;

  Future<void> onPaymentSettingClick() async {
    if (isLoading) return;
    isLoading = true;
    String path = ApiEndPoint.instance.stripeConnectAccount;
    if (authCubit.state.profileModel?.stripeAccountInfo.stripeAccountId.isNotEmpty ?? false) {
      path = ApiEndPoint.instance.stripeLoginLink;
    }

    final response = await _dioService.request<dynamic>(
      input: RequestInput(endpoint: path, method: RequestMethod.POST),
      responseBuilder: (data) => data,
    );

    isLoading = false;
    if (response.isSuccess) {
      if (response.data?['url'] == null) return;
      appRouter.push(
        PaymentWebView(
          checkoutUrl: response.data!['url'],
          onCancel: () {
            appRouter.pop();
          },
          onSuccess: () async {
            await authCubit.getCurrentUser();
            appRouter.pop();
          },
        ),
      );
    } else {
      showSnackBar(response.message ?? '', type: SnackBarType.error);
    }
  }
}
