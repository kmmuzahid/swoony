import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/grid_child_postion.dart';
import 'package:swoony/core/utils/log/app_log.dart';

class SmartStaggeredLoader extends StatefulWidget {
  const SmartStaggeredLoader({
    required this.itemCount,
    required this.itemBuilder,
    this.onRefresh,
    this.onLoadMore,
    this.isLoading = false,
    this.isLoadingMore = false, // new flag for pagination loading
    this.isLoadDone = false,
    this.padding,
    this.maxCrossAxisExtent = 200,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.physics,
    super.key,
    this.topWidget,
    this.enableMassionary = false,
    this.aspectRatio = 1,
    this.appbar,
    this.onColapsAppbar,
    this.isSeperated = false,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Function()? onRefresh;
  final Function()? onLoadMore;
  final bool isLoading; // initial load / refresh loading
  final bool isLoadingMore; // pagination load more loading
  final bool isLoadDone; // all data loaded flag
  final EdgeInsetsGeometry? padding;
  final double maxCrossAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final ScrollPhysics? physics;
  final Widget? topWidget;
  final bool enableMassionary;
  final double aspectRatio;
  final Widget? appbar;
  final Widget? onColapsAppbar;
  final bool isSeperated;

  @override
  State<SmartStaggeredLoader> createState() => _SmartStaggeredLoaderState();
}

class _SmartStaggeredLoaderState extends State<SmartStaggeredLoader>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late AnimationController _animationController;
  bool _isAppBarVisible = true;
  double _lastScrollOffset = 0;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // Start with the app bar visible
    _animationController.forward();
  }

void _onScroll() {
    if (isRefreshing) return; 

    final position = _scrollController.position;

    final isScrollingDown = position.userScrollDirection == ScrollDirection.reverse;

    if (position.pixels < 100) return;

    final isNearBottom = position.pixels >= position.maxScrollExtent - 200;
 
    if (isScrollingDown &&
        isNearBottom &&
        widget.onLoadMore != null &&
        !widget.isLoading &&
        !widget.isLoadingMore &&
        !widget.isLoadDone &&
        widget.itemCount > 0) {
      widget.onLoadMore!();
    }

    // ------- AppBar Logic (unchanged) -------
    if (widget.appbar != null) {
      final currentScroll = position.pixels;
      final maxScroll = position.maxScrollExtent;
      final isAtBottom = currentScroll >= maxScroll;
      final isAtTop = currentScroll <= position.minScrollExtent;

      if (!isAtTop && !isAtBottom) {
        final isScrollingDown = currentScroll > _lastScrollOffset && currentScroll > 0;

        if (isScrollingDown && _isAppBarVisible) {
          _isAppBarVisible = false;
          setState(() {});
          _animationController.reverse();
        } else if (!isScrollingDown && !_isAppBarVisible) {
          _isAppBarVisible = true;
          setState(() {});
          _animationController.forward();
        }
      } else if (isAtTop && !_isAppBarVisible) {
        _isAppBarVisible = true;
        setState(() {});
        _animationController.forward();
      }

      _lastScrollOffset = currentScroll;
    }
}

Future<void> _onRefresh() async {
    if (isRefreshing) return;

    isRefreshing = true;
    setState(() {});

    await widget.onRefresh?.call();
 
    isRefreshing = false;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildGrid({ScrollController? controller, ScrollPhysics? physics}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.custom(
          controller: controller,
          key: ValueKey('staggered${widget.itemCount}'),
          physics: physics ?? const AlwaysScrollableScrollPhysics(),
          padding: widget.padding,
          shrinkWrap: physics is NeverScrollableScrollPhysics,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: widget.aspectRatio,
            maxCrossAxisExtent: widget.maxCrossAxisExtent,
            mainAxisSpacing: widget.mainAxisSpacing,
            crossAxisSpacing: widget.isSeperated ? 0 : widget.crossAxisSpacing,
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: widget.itemCount + (widget.isLoadingMore ? 1 : 0),
            (context, index) {
              if (index < widget.itemCount) {
                if (widget.isSeperated) {
                  return RepaintBoundary(
                    child: _seprated(
                      index,
                      widget.itemBuilder(context, index),
                      constraints.maxWidth,
                    ),
                  );
                }
                return RepaintBoundary(child: widget.itemBuilder(context, index));
              } else if (widget.isLoadingMore) {
                // Show load more indicator at the bottom of list
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (widget.isLoadDone) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: Text('All data loaded')),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    // Show placeholder if no data with loading or empty text
    if (widget.itemCount == 0) {
      final placeholder = ListView(
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        padding: widget.padding ?? EdgeInsets.all(16.w),
        children: [
          if (widget.isLoading) // only initial loading shows full screen indicator
            const Center(child: CircularProgressIndicator())
          else if (widget.isLoadDone)
            const Center(child: Text('No data found'))
          else
            SizedBox(height: 300.h), // to enable pull-to-refresh overscroll
        ],
      );

      return widget.onRefresh != null
          ? RefreshIndicator(
              onRefresh: _onRefresh,
              child: placeholder,
            )
          : placeholder;
    }
  
    

    // Show staggered grid with optional pull-to-refresh
    final grid = widget.topWidget == null
        ? _buildGrid(physics: const AlwaysScrollableScrollPhysics(), controller: _scrollController)
        : SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                widget.topWidget!,
                _buildGrid(physics: const NeverScrollableScrollPhysics()),
              ],
            ),
          );

    return widget.onRefresh != null
        ? RefreshIndicator(
            onRefresh: _onRefresh,
            child: grid,
          )
        : grid;
  }

  Widget _seprated(int index, Widget child, double width) {
    final gridChildPosition = calculateGridChildInfo(
      index: index,
      totalChildren: widget.itemCount,
      crossAxisCount: widget.maxCrossAxisExtent,
      width: width,
    );

    final double spaceing = widget.crossAxisSpacing <= 0 ? 0 : widget.crossAxisSpacing / 2;

    return Container(
      padding: EdgeInsets.only(
        left: gridChildPosition.isLastInRow || gridChildPosition.isMiddleInRow ? spaceing : 0,
        right: gridChildPosition.isFirstInRow || gridChildPosition.isMiddleInRow ? spaceing : 0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: !gridChildPosition.isItInLastRow
              ? BorderSide(color: AppColors.greay100, width: 1.4.w)
              : BorderSide.none,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appbar != null) {
      // Get the app bar height, default to kToolbarHeight if not a PreferredSizeWidget
      final appBarHeight = widget.appbar is PreferredSizeWidget
          ? (widget.appbar as PreferredSizeWidget).preferredSize.height
          : kToolbarHeight;

      return Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: _isAppBarVisible ? 0 : appBarHeight,
              end: _isAppBarVisible ? appBarHeight : 0,
            ),
            builder: (context, height, child) {
              return SizedBox(
                height: height,
                child: OverflowBox(
                  maxHeight: appBarHeight,
                  alignment: Alignment.topCenter,
                  child: widget.appbar,
                ),
              );
            },
          ),
          if (widget.onColapsAppbar != null)
            Container(color: AppColors.background, child: widget.onColapsAppbar!.start),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.only(top: _isAppBarVisible ? 0 : 0),
                child: _buildContent(),
              ),
            ),
          ),
        ],
      );
    }
    return _buildContent();
  }

  GridChildInfo calculateGridChildInfo({
    required int index,
    required int totalChildren,
    required double crossAxisCount, // use int, not double
    required double width,
  }) {
    final childrenInRow = (width / crossAxisCount).round();

    // Total rows
    final totalRows = totalChildren ~/ childrenInRow;

    // Position in the row (0-based)
    final positionInRow = index % crossAxisCount;

    // First / middle / last
    final isFirstInRow = positionInRow == 0;
    final isLastInRow = positionInRow == childrenInRow - 1;
    final isMiddleInRow = !isFirstInRow && !isLastInRow;

    final beforeLastRowItemsCount = (totalRows) * childrenInRow;
    final isItInLastRow = beforeLastRowItemsCount <= index;

    return GridChildInfo(
      childrenInRow: childrenInRow,
      isFirstInRow: isFirstInRow,
      isMiddleInRow: isMiddleInRow,
      isLastInRow: isLastInRow,
      isItInLastRow: isItInLastRow,
    );
  }
}

class GridChildInfo {
  GridChildInfo({
    required this.childrenInRow,
    required this.isFirstInRow,
    required this.isMiddleInRow,
    required this.isLastInRow,
    required this.isItInLastRow,
  });
  final int childrenInRow; // number of items in this row
  final bool isFirstInRow;
  final bool isMiddleInRow;
  final bool isLastInRow;
  final bool isItInLastRow;
}
