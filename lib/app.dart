import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/cubit/app/app_config_bloc.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<AppConfigBloc, AppConfigState>(
        buildWhen: (previousState, state) {
          if (previousState.locale != state.locale) return true;
          return false;
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorKey: AppNavigator.navigatorKey,
            onGenerateRoute: AppNavigator.onGenerateRoute,
            supportedLocales: S.delegate.supportedLocales,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserAuthenticationCubit(),
                )
              ],
              child: const UserAuthenticationPage(),
            ),
          );
        },
      ),
    );
  }
}
