import 'package:flutter/material.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/helpers/debouncer.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Smart list loader widget for the app
class SmartListLoader extends StatefulWidget {
  const SmartListLoader({
    required this.itemCount,
    required this.itemBuilder,
    this.onRefresh,
    this.onLoadMore,
    this.isLoading = false,
    this.isLoadDone = false,
    this.padding,
    this.isReverse = false, // Added reverse flag
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Function()? onRefresh;
  final Function()? onLoadMore;
  final bool isLoading;
  final bool isLoadDone;
  final EdgeInsetsGeometry? padding;
  final bool isReverse; // The reverse flag to toggle reverse chat behavior

  @override
  State<SmartListLoader> createState() => _SmartListLoaderState();
}

class _SmartListLoaderState extends State<SmartListLoader> {
  late final ScrollController _scrollController;
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_debouncer.isRunning) return;
    _debouncer.call(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
          widget.onLoadMore != null &&
          !widget.isLoading &&
          !widget.isLoadDone) {
        widget.onLoadMore!();
      }
    });
  }

  void scrollToFirstItem() {
    if (widget.isReverse) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, // Scroll to the last item (bottom in reverse)
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0.0, // Scroll to the first item (top)
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      padding: widget.padding,
      reverse: widget.isReverse, // This makes the list scroll in reverse order
      itemCount: widget.itemCount + 1,
      itemBuilder: (context, index) {
 
          if (index < widget.itemCount) {
            return widget.itemBuilder(context, index);
        } 
        if (widget.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 80, top: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // All Data Loaded Message
        if (widget.isLoadDone) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(child: Text(AppString.allDataLoaded)),
          );
        }

        return const SizedBox.shrink();
      },
    );

    // If `onRefresh` is provided, wrap in RefreshIndicator
    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh!();
        },
        child: list,
      );
    }

    return list;
  }
}
