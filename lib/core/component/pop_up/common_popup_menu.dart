import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common popup menu widget for the app
class CommonPopupMenu extends StatefulWidget {
  const CommonPopupMenu({
    required this.items,
    required this.onItemSelected,
    super.key,
    this.icons,
    this.initialText,
    this.textStyle,
    this.showTextTrigger = true,
    this.showIconTrigger = false,
    this.triggerIcon = Icons.more_vert,
    this.onPrimaryColor,
    this.primaryColor,
  }) : assert(
         icons == null || icons.length == items.length,
         'If icons are provided, they must match the length of items',
       );
  final List<String> items;
  final List<IconData>? icons;
  final void Function(String selectedItem) onItemSelected;
  final String? initialText;
  final TextStyle? textStyle;
  final bool showTextTrigger; // show main button with text
  final bool showIconTrigger; // show icon trigger
  final IconData triggerIcon;
  final Color? onPrimaryColor;
  final Color? primaryColor;

  @override
  State<CommonPopupMenu> createState() => _SelectablePopupMenuState();
}

class _SelectablePopupMenuState extends State<CommonPopupMenu> {
  String? selectedText;

  @override
  void initState() {
    super.initState();
    selectedText = widget.initialText ?? widget.items.first;
  }

  void _showPopupMenu(BuildContext context, GlobalKey key) async {
    final RenderBox button = key.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + button.size.height,
        position.dx + button.size.width,
        position.dy,
      ),
      color: widget.primaryColor ?? AppColors.serfeceBG,
      shadowColor: AppColors.disable,
      items: List.generate(widget.items.length, (index) {
        return PopupMenuItem<String>(
          value: widget.items[index],
          child: Row(
            children: [
              if (widget.icons != null) Icon(widget.icons![index], size: 18.w),
              if (widget.icons != null) SizedBox(width: 8.w),
              Text(widget.items[index], style: AppTextStyles.titleLarge),
            ],
          ),
        );
      }),
    );

    if (selected != null) {
      setState(() {
        selectedText = selected;
      });
      widget.onItemSelected(selected);
    }
  }

  final GlobalKey _textTriggerKey = GlobalKey();
  final GlobalKey _iconTriggerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTextTrigger)
          GestureDetector(
            key: _textTriggerKey,
            onTap: () => _showPopupMenu(context, _textTriggerKey),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text(
                    selectedText ?? '',
                    style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 8.w),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        if (widget.showIconTrigger)
          IconButton(
            key: _iconTriggerKey,
            icon: Icon(widget.triggerIcon),
            onPressed: () => _showPopupMenu(context, _iconTriggerKey),
          ),
      ],
    );
  }
}
