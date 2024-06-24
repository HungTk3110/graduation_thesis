import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/model/categories.dart';
import 'package:untitled1/models/model/task.dart';
import 'package:untitled1/navigator/fade_page_route.dart';
import 'package:untitled1/navigator/transitions.dart';
import 'package:untitled1/ui/category/category_cubit.dart';
import 'package:untitled1/ui/category/category_page.dart';
import 'package:untitled1/ui/home/home_page.dart';
import 'package:untitled1/ui/profile/profile_cubit.dart';
import 'package:untitled1/ui/profile/profile_page.dart';
import 'package:untitled1/ui/search/search_cubit.dart';
import 'package:untitled1/ui/search/search_page.dart';
import 'package:untitled1/ui/task/task_argument.dart';
import 'package:untitled1/ui/task/task_cubit.dart';
import 'package:untitled1/ui/task/task_page.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_page.dart';

enum Routes {
  home,
  profile,
  category,
  task,
  search,
  authen,
}

class _Paths {
  static const String home = "/home";
  static const String profile = "/profile";
  static const String category = "/category";
  static const String task = "/task";
  static const String search = "/search";
  static const String authen = "/authen";

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.home,
    Routes.profile: _Paths.profile,
    Routes.category: _Paths.category,
    Routes.task: _Paths.task,
    Routes.search: _Paths.search,
    Routes.authen: _Paths.authen,
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
      case _Paths.task:
        var arguments = settings.arguments;
        var task = arguments is TaskArgument ? arguments : null;
        return Transitions(
          transitionType: TransitionType.slideLeft,
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TaskCubit(),
              )
            ],
            child:  TaskPage(
              taskArgument: task,
            ),
          ),
        );
      case _Paths.category:
        var arguments = settings.arguments;
        var indexCategories = arguments is int ? arguments : 0;
        return Transitions(
          transitionType: TransitionType.slideLeft,
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CategoryCubit(),
              )
            ],
            child: CategoryPage(
              indexCategories: indexCategories,
            ),
          ),
        );
      case _Paths.search:
        return Transitions(
          transitionType: TransitionType.slideLeft,
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchCubit(),
              )
            ],
            child: const SearchPage(),
          ),
        );
      case _Paths.authen:
        return Transitions(
          transitionType: TransitionType.slideLeft,
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>  UserAuthenticationCubit(),
              )
            ],
            child: const UserAuthenticationPage(),
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
