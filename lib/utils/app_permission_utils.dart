import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionUtils {
  static Future<bool> askPhotoLibraryPermission(VoidCallback? onDenied) async {
    PermissionStatus? permissionStatus;

    if (Platform.isAndroid) {
      final isAndroid13orHigher = await _isAndroid13orHigher();
      if (isAndroid13orHigher) {
        permissionStatus = await Permission.photos.request();
      } else {
        permissionStatus = await Permission.storage.request();
      }
    } else {
      permissionStatus = await Permission.photos.request();
    }

    final isDenied = _handlePermission(
      permissionStatus,
      onDenied: onDenied,
    );

    return isDenied;
  }

  static Future<bool> askCameraPermission(VoidCallback? onDenied) async {
    PermissionStatus? permissionStatus = await Permission.camera.request();

    final isDenied = _handlePermission(
      permissionStatus,
      onDenied: onDenied,
    );

    return isDenied;
  }

  static Future<bool> askFileMediaPermission(VoidCallback? onDenied) async {
    PermissionStatus? permissionStatus = await Permission.camera.request();

    if (Platform.isAndroid) {
      final isAndroid13orHigher = await _isAndroid13orHigher();
      if (isAndroid13orHigher) {
        permissionStatus = await Permission.manageExternalStorage.request();
      } else {
        permissionStatus = await Permission.storage.request();
      }
    } else {
      permissionStatus = await Permission.storage.request();
    }

    final isDenied = _handlePermission(
      permissionStatus,
      onDenied: onDenied,
    );

    return isDenied;
  }

  static bool _handlePermission(
    PermissionStatus permissionStatus, {
    VoidCallback? onDenied,
  }) {
    switch (permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        return false;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        onDenied?.call();
        return true;
      default:
        return false;
    }
  }

  static Future<bool> _isAndroid13orHigher() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;

      return info.version.sdkInt >= 33;
    }
    return false;
  }
}
