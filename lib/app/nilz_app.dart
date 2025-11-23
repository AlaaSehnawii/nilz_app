import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../core/theme/app_theme.dart';
import '../router/app_router.dart';

final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

class NilzApp extends StatefulWidget {
  final bool isLoggedIn;
  const NilzApp({super.key, required this.isLoggedIn});

  @override
  State<NilzApp> createState() => _SoaMAppState();
}

class _SoaMAppState extends State<NilzApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String startRoute = widget.isLoggedIn
        ? AppRouterScreenNames.dashboard
        : AppRouterScreenNames.login;

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          navigatorKey: appKey,
          locale: context.locale,
          theme: lightTheme(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: startRoute,
        );
      },
    );
  }
}
