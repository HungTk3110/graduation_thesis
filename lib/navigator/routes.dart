import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/navigator/fade_page_route.dart';
import 'package:untitled1/navigator/transitions.dart';
import 'package:untitled1/ui/home/home_page.dart';
import 'package:untitled1/ui/profile/profile_cubit.dart';
import 'package:untitled1/ui/profile/profile_page.dart';

enum Routes {
  home,
  profile,
}

class _Paths {
  static const String home = "/home";
  static const String profile = "/profile";

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.home,
    Routes.profile: _Paths.profile,
  };

  static String of(Routes route) => _pathMap[route] ?? home;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case _Paths.splash:
      //   return FadeRoute(page: const SplashPage());
      // case _Paths.trial:
      //   return FadeRoute(page: const FreeTrialPage());
      // case _Paths.premium:
      //   return Transitions(
      //       transitionType: TransitionType.slideLeft,
      //       page: const PremiumPage());
      case _Paths.home:
        return Transitions(
            transitionType: TransitionType.slideLeft, page: const HomePage());
      case _Paths.profile:
        return Transitions(
          transitionType: TransitionType.slideLeft,
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProfileCubit(),
              )
            ],
            child: const ProfilePage(),
          ),
        );
      default:
        return FadeRoute(page: const HomePage());
    }
  }

  // static void push<T>(Routes route, [T? arguments]) =>
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       state?.pushNamed(_Paths.of(route), arguments: arguments);
  //     });

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static Future? pushAndRemove<T>(Routes route, [T? arguments]) =>
      state?.pushNamedAndRemoveUntil(_Paths.of(route), (route) => false);

  static void pop({dynamic result}) => state?.pop(result);

  static NavigatorState? get state => navigatorKey.currentState;
}
