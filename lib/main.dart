import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nilz_app/app/nilz_app.dart';
import 'package:package_info_plus/package_info_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'core/helper/app_info_helper.dart';
import 'core/injection/injection_container.dart';
import 'core/resource/constant_manager.dart';
import 'core/resource/key_manger.dart';
import 'core/storage/shared/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final shPref = await SharedPreferences.getInstance();
  AppSharedPreferences.init(shPref);

  await initDI();
  final isLoggedIn = AppSharedPreferences.getToken().isNotEmpty;

  AppInfoHelper.packageInfo = await PackageInfo.fromPlatform();


  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppKeyManager.arabicLocalizationCode),
        Locale(AppKeyManager.englishLocalizationCode),
      ],
      path: AppConstantManager.assetTranslationPath,
      fallbackLocale: const Locale(AppKeyManager.arabicLocalizationCode),
      startLocale: Locale(AppSharedPreferences.getLanguage()),
      child: NilzApp(isLoggedIn: isLoggedIn),
    ),
  );
}
