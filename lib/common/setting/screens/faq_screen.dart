import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swoony/common/setting/cubit/faq_cubit.dart';
import 'package:swoony/common/setting/model/faq_model.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/other_widgets/smart_list_loader.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';

@RoutePage()
class FaqScreen extends StatelessWidget {
  const FaqScreen({required this.faqType, super.key});
  final FaqType faqType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FAQ/Help'),
      body: CubitScope(
        create: () => FaqCubit(faqType: faqType)..fetch(),
        builder: (context, cubit, state) {
          return SmartListLoader(
            isLoading: state.isLoading,
            onRefresh: () {
              cubit.fetch(isRefresh: true);
            },
            onLoadMore: cubit.fetch,
            itemCount: state.faq.length,
            itemBuilder: (context, index) {
              final faq = state.faq[index];
              return _faqBuilder(context, faq);
            },
          );
        },
      ),
    );
  }

  Widget _faqBuilder(BuildContext context, FaqModel faq) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: CommonText(
              text: faq.question,
              textAlign: TextAlign.left,
              maxLines: 4,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 12),
              CommonText(
                text: faq.answer,
                maxLines: 20,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
