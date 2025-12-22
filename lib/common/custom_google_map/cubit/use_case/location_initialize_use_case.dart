import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:swoony/core/config/storage/storage_service.dart';
// ignore: depend_on_referenced_packages
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/component/other_widgets/permission_handler_helper.dart';

class LocationInitializationUseCase {
  const LocationInitializationUseCase(this.lastLocationKey);
  final String lastLocationKey;

  Future<bool> checkPermission() async {
    final permission = await const PermissionHandlerHelper(
      permission: Permission.location,
    ).getStatus();
    return permission;
  }

  Future<Position?> loadLastLocation() async {
    final jsonString = await StorageService.instance.read(lastLocationKey);
    if (jsonString != null) {
      return Position.fromMap(json.decode(jsonString));
    }
    return null;
  }

  Future<Position?> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  /// Fast path: return last known position if recent (<= 1 minute), otherwise get fresh.
  /// Handles service/permission states and errors, returning null on failure.
  Future<Position?> getCurrentPositionFast() async {
    try {
      // Ensure service is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      // Ensure permission is granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // Try last known first
      final last = await Geolocator.getLastKnownPosition();
      if (last != null) {
        final age = DateTime.now().difference(last.timestamp);
        if (age <= const Duration(minutes: 1)) {
          return last;
        }
      }
      // Fallback to a fresh position
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  Future<void> savePosition(Position position) async {
    await StorageService.instance.write(lastLocationKey, json.encode(position.toJson()));
  }
}
