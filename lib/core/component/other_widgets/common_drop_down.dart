import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDropDown<T> extends StatefulWidget {
  const CommonDropDown({
    required this.hint,
    required this.items,
    required this.onChanged,
    required this.nameBuilder,
    this.isRequired = false,
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
    this.isLoading = false,
    this.borderRadius = 12,
    this.prefix,
    this.initalValue,
    this.enableInitalSelection = true,
    super.key,
  });

  final String hint;
  final List<T> items;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Function(T? value) onChanged;
  final String Function(T value) nameBuilder;
  final bool isRequired;
  final bool isLoading;
  final double borderRadius;
  final Widget? prefix;
  final bool enableInitalSelection;
  final T? initalValue;

  @override
  State<CommonDropDown<T>> createState() => _CommonDropDownState<T>();
}

class _CommonDropDownState<T> extends State<CommonDropDown<T>> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  T? _selectedItem;
  late List<T> _items;

@override
  void initState() {
    super.initState();
    _items = widget.items;
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();

    // For MapEntry, we need to compare keys/values instead of the entire object
    if (widget.initalValue != null) {
      if (widget.initalValue is MapEntry) {
        _selectedItem = _items.firstWhere(
          (item) =>
              item is MapEntry && (item as MapEntry).key == (widget.initalValue as MapEntry).key,
          orElse: () => _items.isNotEmpty ? _items.first : widget.initalValue!,
        );
      } else {
        _selectedItem = _items.contains(widget.initalValue)
            ? widget.initalValue
            : (_items.isNotEmpty ? _items.first : null);
      }
    } else if (_items.isNotEmpty) {
      _selectedItem = _items.first;
    }

    // Notify parent if we have a selected item
    if (_selectedItem != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged(_selectedItem);
      });
    }
  }

  @override
  void didUpdateWidget(covariant CommonDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle items update
    if (widget.items != oldWidget.items) {
      _items = widget.items;

      // Try to find the selected item in the new items list
      if (_selectedItem != null) {
        if (_selectedItem is MapEntry) {
          _selectedItem = _items.firstWhere(
            (item) => item is MapEntry && (item as MapEntry).key == (_selectedItem as MapEntry).key,
            orElse: () => _items.isNotEmpty ? _items.first : _selectedItem!,
          );
        } else if (!_items.contains(_selectedItem) && _items.isNotEmpty) {
          _selectedItem = _items.first;
        }
      } else if (_items.isNotEmpty) {
        _selectedItem = _items.first;
      }

      if (_selectedItem != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged(_selectedItem);
        setState(() {});
      });
    }
  }
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isLoading
        ? AppColors.primaryColor
        : widget.borderColor ?? AppColors.disable;

    return Stack(
      alignment: Alignment.center,
      children: [
        DropdownButtonFormField<T>(
          style: widget.textStyle,
          onSaved: (value) {
            widget.onChanged(value);
          },

          validator: (value) {
            if (widget.isRequired &&
                (value == null || !widget.items.any((item) => _itemsEqual(item, value)))) {
              return '${widget.hint} is required';
            }
            return null;
          },
          initialValue: (widget.enableInitalSelection || widget.initalValue != null)
              ? _selectedItem
              : null,
          decoration: InputDecoration(
            isDense: true,
            filled: widget.backgroundColor != null,
            fillColor: widget.backgroundColor,
            prefixIcon: widget.prefix != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: widget.prefix,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: EdgeInsets.only(left: 10.w, right: 2.w, top: 14.w, bottom: 14.w),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.borderRadius.r)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.w),
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.w),
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
            ),
          ),
          hint: CommonText(
            text: widget.hint,
            style: TextStyle(fontSize: widget.textStyle?.fontSize, color: AppColors.outlineColor),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          dropdownColor: AppColors.serfeceBG,
          isExpanded: true,
          items: _items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: CommonText(text: widget.nameBuilder(item), style: widget.textStyle),
                ),
              )
              .toList(),
          onChanged: (T? newValue) {
            if (newValue == null) return;

            // Find the matching item from the original items list
            final matchingItem = widget.items.firstWhere(
              (item) => _itemsEqual(item, newValue),
              orElse: () => newValue,
            );

            setState(() {
              _selectedItem = matchingItem;
            });
            widget.onChanged(matchingItem);
          },
        ),

        // Animated border while loading
        if (widget.isLoading)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return CustomPaint(
                  painter: _BorderLoaderPainter(
                    _controller.value,
                    borderColor,
                    widget.borderRadius,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  bool _itemsEqual(T a, T b) {
    if (a is MapEntry && b is MapEntry) {
      return a.key == b.key && a.value == b.value;
    }
    return a == b;
  }
}

class _BorderLoaderPainter extends CustomPainter {
  _BorderLoaderPainter(this.progress, this.color, this.borderRadius);
  final double progress; // 0.0 to 1.0
  final Color color;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)));

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.w
      ..style = PaintingStyle.stroke;

    final dashWidth = 50.0.w;
    final dashSpace = 1.0.w;
    final totalLength = (dashWidth + dashSpace);
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = progress * metric.length;

      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += totalLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BorderLoaderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
