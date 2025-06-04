import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  // For Android 11+, use manageExternalStorage
  if (await Permission.manageExternalStorage.isGranted ||
      await Permission.storage.isGranted) {
    // Already granted
    return;
  }

  // Request permission
  if (await Permission.manageExternalStorage.request().isGranted ||
      await Permission.storage.request().isGranted) {
    // Permission granted
    log('Storage permission granted');
  } else {
    // Permission denied (you can guide the user to settings)
    log('Storage permission denied');
    openAppSettings(); // Optional: open settings so user can enable manually
  }
}
