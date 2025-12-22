import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/custom_google_map/cubit/map_cubit/map_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

import '../cubit/map_search_cubit/map_search_cubit.dart';
import '../cubit/map_search_cubit/map_search_state.dart';

class MapSearchBar extends StatefulWidget {
  const MapSearchBar({
    required this.hints,
    required this.onSubmit,
    required this.icon,
    required this.onTap,
    this.onCurrentPosition,
    this.initalAddress,
    this.radious = 0,
    super.key,
  });

  final String hints;
  final Function({required String placeId, required String address}) onSubmit;
  final Function onTap;
  final Function? onCurrentPosition;
  final Widget icon;
  final String? initalAddress;
  final double radious;

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  late SearchController controller;
  bool isListenerAdded = false;
  late FocusNode focusNode;

  @override
  void initState() {
    controller = SearchController();
    focusNode = FocusNode();
    controller.text = widget.initalAddress ?? '';

    context.read<MapCubit>().stream.listen((data) {
      controller.text = widget.initalAddress ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapSearchCubit(), //hints as unique id here
      child: LayoutBuilder(
        builder: (context, contstrain) {
          final cubit = context.read<MapSearchCubit>();
          return SearchAnchor(
            searchController: controller,
            viewLeading: widget.icon,

            viewShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radious.w),
            ),
            viewBackgroundColor: Colors.white,
            isFullScreen: false,
            viewOnChanged: cubit.getPlaceSuggestions,
            viewOnSubmitted: (value) {
              _performSearch(
                context,
                controller,
                cubit.state.searchResults.isEmpty ? null : cubit.state.searchResults.entries.first,
              );
            },
            builder: (_, c) => SearchBar(
              controller: controller,
              focusNode: focusNode,
              onTapOutside: (event) {
                focusNode.unfocus();
              },
              hintText: widget.hints,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () {
                c.openView();
                widget.onTap();
              },
              leading: widget.icon,
            ),
            suggestionsBuilder: (_, searchController) {
              return _suggenstionsBuilder(cubit, controller);
            },
          );
        },
      ),
    );
  }

  void _performSearch(
    BuildContext context,
    SearchController controller,
    MapEntry<String, String>? searchItem,
  ) {
    FocusScope.of(context).unfocus();
    if (searchItem == null) return;
    controller.text = '';
    controller.closeView(searchItem.value);
    widget.onSubmit(placeId: searchItem.key, address: searchItem.value);
  }

  List<Widget> _buildSuggestions({
    required BuildContext context,
    required Map<String, String> suggestions,
    required VoidCallback onClear,
  }) {
    return [
      if (suggestions.isNotEmpty)
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(onPressed: onClear, child: const Text('Clear All')),
        ),
      ...suggestions.entries.map((item) {
        return ListTile(
          title: Text(item.value),
          onTap: () {
            controller.text = item.value;
            controller.closeView(item.value);

            widget.onSubmit(placeId: item.key, address: item.value);
          },
        );
      }),
    ];
  }

  FutureOr<Iterable<Widget>> _suggenstionsBuilder(
    MapSearchCubit cubit,
    SearchController controller,
  ) {
    return [
      StreamBuilder<MapSearchState>(
        stream: cubit.stream,
        initialData: cubit.state,
        builder: (context, snapshot) {
          final state = snapshot.data!;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.searchResults.isEmpty) {
            return const Padding(padding: EdgeInsets.all(16.0), child: Text('No search history.'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.searchResults.isNotEmpty)
                ..._buildSuggestions(
                  context: context,
                  suggestions: state.searchResults,
                  onClear: cubit.onClear,
                ),
            ],
          );
        },
      ),
    ];
  }
}
