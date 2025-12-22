// File: chat_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/chat/cubit/chat/chat_cubit.dart';
import 'package:swoony/common/chat/cubit/chat/chat_state.dart';
import 'package:swoony/common/chat/model/chat_list_item_model.dart';
import 'package:swoony/common/chat/model/chat_model.dart';
import 'package:swoony/common/chat/widgets/file_thumbnail_grid.dart';
import 'package:swoony/common/chat/widgets/upload_files_widget.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/other_widgets/common_draggable_bottom_sheet.dart';
import 'package:swoony/core/component/other_widgets/muiltiple_selector.dart';
import 'package:swoony/core/component/other_widgets/smart_list_loader.dart';
import 'package:swoony/core/component/pop_up/common_popup_menu.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_multiline_text_field.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/main.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  ChatScreen({required this.chatListItemModel, super.key, this.action})
    : chatIemWidth = (Utils.deviceSize.width - 32) * .7;
  final Widget? action;
  final double chatIemWidth;
  final ChatListItemModel chatListItemModel;

  @override
  Widget build(BuildContext context) => CubitScope(
    create: () => ChatCubit(chatListItemModel.chatId)..init(),
    builder: (context, cubit, state) {
      final userId = context.read<AuthCubit>().state.profileModel?.id;
      return Scaffold(
        appBar: _appBar(context, cubit),
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: SmartListLoader(
                  isReverse: true,
                  onLoadMore: cubit.loadMore,
                  isLoading: state.isLoading,
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) =>
                      _chatItem(state.chats[index], context, cubit, index),
                ),
              ),
              CustomForm(
                builder: (context, formKey) {
                  return SizedBox(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 20),
                        child: Column(
                          children: [
                            if (state.filePath.isNotEmpty) ...[
                              UploadFilesWidget(files: state.filePath, onRemove: cubit.removeFile),
                              const Divider(color: Colors.white),
                            ],
                            CommonTextField(
                              hintText: AppString.typeYourMessage,
                              backgroundColor: AppColors.greay50,
                              suffixIcon: _suffix(cubit, formKey, userId),
                              key: Key(state.message),
                              validationType: ValidationType.notRequired,
                              borderColor: AppColors.greay50,
                              onSaved: (value, controller) {
                                cubit.onMessageChange(message: value);
                                controller.text = '';
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  Row _suffix(ChatCubit cubit, GlobalKey<FormState> formKey, String? userId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: cubit.pickImage,
          child: Icon(Icons.attach_file, color: AppColors.greay500),
        ),
        2.width,
        GestureDetector(
          onTap: () => cubit.pickImage(isAttachment: false),
          child: Icon(Icons.image, color: AppColors.greay500),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          color: AppColors.greay500,
          width: 2.w,
          height: 20.h,
        ),
        GestureDetector(
          onTap: () {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();
              cubit.send(userId: userId ?? '');
            }
          },
          child: Icon(Icons.send, color: AppColors.greay500),
        ),
        10.width,
      ],
    );
  }

  Widget editMessageFiled(
    ChatModel model,
    BuildContext context,
    ChatCubit cubit,
    int index,
    bool isMe,
  ) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: chatIemWidth, minWidth: 105.w),
        child: CustomForm(
          builder: (context, formKey) {
            return Column(
              children: [
                CommonTextField(
                  initialText: model.content,
                  hintText: AppString.typeYourMessage,
                  backgroundColor: AppColors.greay50,
                  validationType: ValidationType.notRequired,
                  borderColor: AppColors.greay50,
                  onSaved: (value, controller) {
                    cubit.editMessage(message: value, messageId: model.messageId, index: index);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        cubit.disableEdit(index);
                      },
                      icon: Icon(Icons.close, color: AppColors.greay),
                    ),
                    IconButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          formKey.currentState?.save();
                        }
                      },
                      icon: Icon(Icons.check, color: AppColors.primaryButton),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _chatItem(ChatModel model, BuildContext context, ChatCubit cubit, int index) {
    final bool isImageOnly = model.files?.isNotEmpty == true && model.content.isEmpty;
    final Color isMeBackground = AppColors.primaryColor;
    final Color isMeText = AppColors.textWhite;
    final bool isMe = model.userInfo.userId == context.read<AuthCubit>().state.profileModel?.id;
    //return edit if edit
    if (model.isEdit) return editMessageFiled(model, context, cubit, index, isMe);
    final bool isFaild = model.isSendingFaild;
    final bool isSending = model.isSending;
    final bool isEdited = model.createdAt != model.updatedAt;
    LongPressStartDetails? details;
    return Column(
      children: [
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: chatIemWidth, minWidth: 105.w),
            child: GestureDetector(
              onLongPressStart: (value) {
                details = value;
              },
              onLongPress: () {
                longPressActions(model, details, context, isMe, cubit, index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isImageOnly
                      ? null
                      : (isMe ? isMeBackground : getTheme.dividerColor.withAlpha(20)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      if (model.files?.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: FileThumbnailGrid(files: model.files!),
                        ),
                      if (model.content.isNotEmpty)
                        CommonText(
                          text: model.content,
                          textColor: isMe ? isMeText : null,
                          fontSize: 16.sp,
                          autoResize: false,
                          textAlign: TextAlign.left,
                          maxLines: 100,
                        ),
                      if (model.chatType == ChatType.callFailed)
                        Row(
                          children: [
                            Icon(
                              Icons.call_missed_rounded,
                              color: isMe
                                  ? getTheme.textTheme.bodySmall?.color
                                  : getTheme.colorScheme.error,
                            ),
                            CommonText(
                              text: 'Voice Call',
                              textColor: isMe
                                  ? getTheme.textTheme.bodySmall?.color
                                  : getTheme.colorScheme.error,
                            ),
                          ],
                        ),
                      if (model.chatType == ChatType.callSuccess)
                        Row(
                          children: [
                            Icon(isMe ? Icons.call_made : Icons.call_received),
                            const CommonText(text: 'Voice Call'),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (!model.isSending && !model.isSendingFaild)
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: CommonText(
              left: isMe ? 0 : 10.w,
              right: isMe ? 10.w : 0,
              text: '${Utils.formatDateTime(model.createdAt)} ${isEdited ? ' [Edited]' : ''}',
              textColor: AppColors.primaryText,
            ),
          ),
        if (model.isSending && !model.isSendingFaild)
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: CommonText(
              left: isMe ? 0 : 10.w,
              right: isMe ? 10.w : 0,
              text: 'Sending...',
              textColor: AppColors.primaryText,
            ),
          ),
        if (model.isSendingFaild)
          GestureDetector(
            onTap: () {
              cubit.resendMessage(messageId: model.messageId);
            },
            child: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: CommonText(
                left: isMe ? 0 : 10.w,
                right: isMe ? 10.w : 0,
                text: 'Failed',
                suffix: Icon(Icons.restart_alt, color: AppColors.error),
                textColor: AppColors.primaryText,
              ),
            ),
          ),
        10.height,
      ],
    );
  }

  void longPressActions(
    ChatModel model,
    LongPressStartDetails? details,
    BuildContext context,
    bool isMe,
    ChatCubit cubit,
    int index,
  ) {
    final String phoneNumber =
        RegExp(
          r'(?:\+?880|00880)?1[3-9]\d{8}',
        ).firstMatch(model.content)?.group(0)?.replaceAll(RegExp(r'[^0-9+]'), '') ??
        '';
    if (details != null)
      _showPopupMenu(
        tapPosition: details.globalPosition,
        context: context,
        items: [
          'Copy',
          if (phoneNumber.isNotEmpty) 'Call',
          if (phoneNumber.isNotEmpty) 'Message',
          if (isMe) 'Edit',
          if (isMe) 'Delete',
          // 'Reply',
        ],
        icons: [
          Icons.copy,
          if (phoneNumber.isNotEmpty) Icons.call,
          if (phoneNumber.isNotEmpty) Icons.message,
          if (isMe) Icons.delete,
          if (isMe) Icons.edit,
          Icons.reply,
        ],
        onItemSelected: (value) async {
          if (value == 'Copy') {
            await Clipboard.setData(ClipboardData(text: model.content));
          } else if (value == 'Delete') {
            cubit.deleteMessage(messageId: model.messageId);
          } else if (value == 'Call') {
            //show phone number to phone dailer to make a call
            final phoneUrl = 'tel:$phoneNumber';
            if (await canLaunchUrl(Uri.parse(phoneUrl))) {
              await launchUrl(Uri.parse(phoneUrl));
            } else {
              showSnackBar('Could not launch phone app', type: SnackBarType.error);
            }
          } else if (value == 'Reply') {
          } else if (value == 'Message') {
            if (await canLaunchUrl(Uri(scheme: 'sms', path: phoneNumber))) {
              await launchUrl(Uri(scheme: 'sms', path: phoneNumber));
            } else {
              showSnackBar('Could not launch messaging app', type: SnackBarType.error);
            }
          } else if (value == 'Edit') {
            cubit.enableEdit(index);
          }
        },
      );
  }

  void _showPopupMenu({
    required BuildContext context,
    required List<String> items,
    List<IconData>? icons,
    required Function onItemSelected,
    required Offset tapPosition,
  }) async {
    final screenSize = MediaQuery.of(context).size;

    // Calculate position with bounds checking
    final double left = tapPosition.dx.clamp(
      0.0,
      screenSize.width - 200,
    ); // 200 is the estimated menu width
    final double top = (tapPosition.dy + 10).clamp(
      0.0,
      screenSize.height - 200,
    ); // 200 is the estimated menu height

    final position = RelativeRect.fromLTRB(
      left,
      top,
      left + 1, // Add minimal width to avoid errors
      top + 1, // Add minimal height to avoid errors
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,

      color: AppColors.serfeceBG,
      shadowColor: AppColors.disable,
      items: List.generate(items.length, (index) {
        return PopupMenuItem<String>(
          value: items[index],
          child: Row(
            children: [
              if (icons != null) Icon(icons![index], size: 18.w),
              if (icons != null) SizedBox(width: 8.w),
              Text(items[index], style: AppTextStyles.titleLarge),
            ],
          ),
        );
      }),
    );

    if (selected != null) {
      onItemSelected(selected);
    }
  }

  CommonAppBar _appBar(BuildContext context, ChatCubit cubit) {
    return CommonAppBar(
      isCenterTitle: false,
      titleWidget: Row(
        children: [
          CommonImage(imageSrc: chatListItemModel.userImage, size: 35, borderRadius: 7),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: chatListItemModel.userName,
                fontWeight: FontWeight.w600,
                textColor: AppColors.greay400,
                fontSize: 16,
              ),
              // CommonText(text: chatListItemModel.userStatus.displayName),
            ],
          ),
        ],
      ),
      actions: [
        CommonPopupMenu(
          showTextTrigger: false,
          onPrimaryColor: AppColors.primaryText,
          // primaryColor: AppColors.primaryColor,
          showIconTrigger: true,
          items: [AppString.report],
          onItemSelected: (value) {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: AppColors.backgroundWhite,
              context: context,
              constraints: const BoxConstraints(minWidth: double.infinity),
              builder: (context) {
                final keyboard = MediaQuery.of(context).viewInsets.bottom;
                return AnimatedPadding(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.only(bottom: keyboard),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 460.h, minWidth: double.infinity),
                    child: expandedContent(cubit: cubit),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget collapsedContent() {
    return CommonText(
      text: '${AppString.selectReasons}:',
      style: AppTextStyles.titleLarge?.copyWith(color: AppColors.primaryColor),
    );
  }

  Widget expandedContent({required ChatCubit cubit}) {
    final listOfReasons = [
      AppString.privacyConcerns,
      AppString.eroticContent,
      AppString.copyrightViolations,
      AppString.defamation,
      AppString.obscene,
      AppString.others,
    ];

    List<String> selectedReasons = [];
    String others = '';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          10.height,
          collapsedContent(),
          SizedBox(
            height: 260.h,
            child: MultipleSelector(
              items: listOfReasons,

              selectedItems: [],
              onChange: (value) {
                selectedReasons = value;
              },
              showSearch: false,
            ),
          ),
          CommonMultilineTextField(
            validationType: ValidationType.notRequired,
            borderColor: AppColors.white300,
            hintText: AppString.otherDetails,
            backgroundColor: AppColors.white300,
            height: 78.h,
            onChanged: (value) {
              others = value;
            },
            onSaved: (p1, controller) {},
          ).paddingSymmetric(horizontal: 16.w),
          10.height,
          CommonButton(
            titleText: AppString.report,
            onTap: () {
              cubit.reportChat(
                chatId: chatListItemModel.chatId,
                selectedReasons: selectedReasons,
                others: others,
              );
            },
          ),
        ],
      ),
    );
  }
}
