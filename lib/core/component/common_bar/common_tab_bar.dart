import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:flutter/material.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common tab bar widget for the app
class CommonTabBar extends StatefulWidget {
  const CommonTabBar({
    required this.tabs,
    required this.tabViews,
    super.key,
    this.selectedStyle,
    this.unselectedStyle,
    this.onTabChange,
    this.selectedTextStyle,
    this.spaceing = 8,
    this.isExpanded = false,
    this.unselectedTextStyle,
  });

  final List<String> tabs;
  final List<Widget> tabViews;
  final bool isExpanded;

  final BoxDecoration? selectedStyle;
  final BoxDecoration? unselectedStyle;

  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Function(int index)? onTabChange;
  final double spaceing;

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> {
  int _selectedIndex = 0; // Keep track of the selected tab index
  Color primaryColor = getTheme.colorScheme.primary.withAlpha(30);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: List.generate(widget.tabs.length, (tabIndex) {
                final isSelected = _selectedIndex == tabIndex;

                final defaultSelectedStyle = BoxDecoration(
                  color: primaryColor, // Replace with AppColors.primaryColor if needed
                  borderRadius: BorderRadius.circular(8),
                );

                final defaultUnselectedStyle = BoxDecoration(
                  border: Border.all(color: primaryColor), // Replace with AppColors.primaryColor
                  borderRadius: BorderRadius.circular(8),
                );

                final defaultSelectedTextStyle = TextStyle(
                  color: getTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                );

                final defaultUnselectedTextStyle = TextStyle(
                  color: _selectedIndex == tabIndex ? primaryColor : getTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: _selectedIndex == tabIndex ? 14 : 12,
                );

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = tabIndex; // Update the selected index
                      });
                      if (widget.onTabChange != null) {
                        widget.onTabChange!(tabIndex);
                      }
                    },
                    child: Container(
                      decoration: isSelected
                          ? (widget.selectedStyle ?? defaultSelectedStyle)
                          : (widget.unselectedStyle ?? defaultUnselectedStyle),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: tabIndex < widget.tabs.length - 1
                          ? EdgeInsets.only(right: widget.spaceing)
                          : null,
                      alignment: Alignment.center,
                      child: Text(
                        widget.tabs[tabIndex],
                        style: isSelected
                            ? (widget.selectedTextStyle ?? defaultSelectedTextStyle)
                            : (widget.unselectedTextStyle ?? defaultUnselectedTextStyle),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 16),
        widget.isExpanded ? Expanded(child: _tabViewContent()) : _tabViewContent(),
      ],
    );
  }

  // This method shows the content corresponding to the selected index using IndexedStack
  Widget _tabViewContent() {
    final index = _selectedIndex < widget.tabViews.length
        ? _selectedIndex
        : widget.tabViews.length - 1;
    return IndexedStack(
      index: index, // Show content corresponding to selected tab index
      children: widget.tabViews,
    );
  }
}
