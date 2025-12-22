import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swoony/common/custom_google_map/model/place_details.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

import '../cubit/map_cubit/map_cubit.dart';
import '../cubit/map_cubit/map_state.dart';
import 'map_search_bar.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({required this.widgets, this.onPositionChange, super.key});
  final List<Widget> Function(BuildContext context, MapState state) widgets;
  final void Function(PlaceDetails details)? onPositionChange;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(onPositionChange),
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          final cubit = context.read<MapCubit>();
          return Stack(
            children: [
              GoogleMap(
                liteModeEnabled: false,

                onTap: (coordinate) {
                  cubit.setPoint(coordinate: coordinate).then((v) async {
                    if (onPositionChange == null) return;
                    onPositionChange!(state.starting);
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: state.starting.coordinate,
                  zoom: 20.0,
                ),
                markers: state.markers,
                polylines: state.mapRoute,
                onMapCreated: (cotroller) {
                  context.read<MapCubit>().onMapCreated(cotroller);
                },
              ),
              Align(alignment: Alignment.topCenter, child: _header(cubit, state)),
              ...widgets(context, state),
              if (state.isLoading)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.white54,
                      border: Border.all(width: 1.w, color: AppColors.primaryColor),
                    ),
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(MapCubit cubit, MapState state) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: MapSearchBar(
      icon: GestureDetector(
        onTap: () {
          cubit.setPointType(PointType.starting).then((_) {
            cubit.setCurrentPosition();
          });
        },
        child: Icon(
          Icons.gps_fixed_outlined,
          color: state.lastPikedPointType == PointType.starting
              ? AppColors.primaryColor
              : AppColors.greay100,
        ),
      ),
      initalAddress: state.starting.address,
      hints: AppString.locations,
      onSubmit: cubit.setCoordinateFromPlaceId,
      onTap: () {
        cubit.setPointType(PointType.starting);
      },
    ),
  );
}
