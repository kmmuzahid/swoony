import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/organizer/createTicket/cubit/create_ticket_state.dart';

import '../cubit/create_ticket_cubit.dart';
import '../widgets/ticket_form_two.dart';

@RoutePage()
class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({Key? key, this.draftId}) : super(key: key);
  final String? draftId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CreateTicketCubit();
        if (draftId != null) {
          //needed it to smooth transitions from the parent screen.
          Future.delayed(const Duration(milliseconds: 300)).then((v) {
            cubit.fetchDraft(id: draftId!);
          });
        }
        return cubit;
      },
      child: BlocBuilder<CreateTicketCubit, CreateTicketState>(
        builder: (context, state) {
          if (state.isDraftFetching) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final bool isBackDisabled =
              (state.currentPage == 1 || (state.currentPage == 2 && !state.isExpandedView));

          return Scaffold(
            appBar: CommonAppBar(
              disableBack: isBackDisabled,
              onBackPress: () {
                final cubit = context.read<CreateTicketCubit>();
                if (isBackDisabled) {
                  cubit.previousPage();
                }
              },
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FutureBuilder(
                    future: Future.wait([
                      Future.microtask(
                        () => TicketFormTwo(
                          createEventModel: state.draftEventModel,
                          isReadOnly: state.isReadOnly,
                          isExpanded: state.isExpandedView,
                          cubit: context.read(),
                        ),
                      ),
                    ]),
                    builder: (context, AsyncSnapshot<List<Widget>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final forms = snapshot.data!;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Offstage(
                              offstage: !(state.currentPage == 0 || state.isExpandedView),
                              child: forms[0],
                            ),
                            Offstage(
                              offstage: !(state.currentPage == 1 || state.isExpandedView),
                              child: forms[1],
                            ),
                            Offstage(
                              offstage: !(state.currentPage == 2 || state.isExpandedView),
                              child: forms[2],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
