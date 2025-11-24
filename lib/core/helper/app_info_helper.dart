import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

abstract class AppInfoHelper {
  static PackageInfo? packageInfo;

  /// 0 app is in background 1 app is in foreground
  /// the default value is foreground
  static int appStatus = 1;

  static bool isForeground() {
    return appStatus == 1;
  }

  static bool isBackground() {
    return appStatus == 0;
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static String getAppVersion() {
    return packageInfo?.version ?? "";
  }
}
