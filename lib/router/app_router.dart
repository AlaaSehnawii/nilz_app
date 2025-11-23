import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nilz_app/core/widget/page/not_found_page.dart';
import 'package:nilz_app/feature/auth/login/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:nilz_app/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/presentation/cubit/pending_req_cubit.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/cubit/res_statistics_cubit.dart';
import 'package:nilz_app/feature/navbar/navbar.dart';
import '../core/navigation/fade_builder_route.dart';
import '../core/injection/injection_container.dart' as di;
import '../core/navigation/slid_up_builder_route.dart';
import '../feature/intro/presentation/splash_screen.dart';

abstract class AppRouterScreenNames {
   static String init = login;

  // AppSharedPreferences.getToken().isEmpty ? login : mainBottomAppBar;

  static const String mainBottomAppBar = "/main-bottom-app-bar";
  static const String login = "/login";
  static const String splash = "/splash";
  static const String dashboard = "/dashboard";
}

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    debugPrint('onGenerateRoute -> ${settings.name}');
    final args = (settings.arguments is Map)
        ? (settings.arguments as Map)
        : const {};
    final fromSplash = args['fromSplash'] == true;

    switch (settings.name) {
      case AppRouterScreenNames.splash:
        return FadeBuilderRoute(page: const SplashScreen());

      case AppRouterScreenNames.login:
        {
          final page = BlocProvider(
            create: (context) => di.sl<LoginCubit>(),
            child: LoginScreen(),
          );
          return fromSplash
              ? SlidUpBuilderRoute(page: page)
              : FadeBuilderRoute(page: page);
        }

      case AppRouterScreenNames.dashboard:
        {
          final page = MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    di.sl<ResStatisticsCubit>()
                      ..getResStatistics(context: context),
              ),
              BlocProvider(
                create: (context) =>
                    di.sl<PendingRequestCubit>()
                      ..getPendingRequest(context: context),
              ),
            ],
            child: NavBar(),
          );
          return fromSplash
              ? SlidUpBuilderRoute(page: page)
              : FadeBuilderRoute(page: page);
        }

      default:
        return MaterialPageRoute(builder: (context) => const NotFoundScreen());
    }
  }
}
