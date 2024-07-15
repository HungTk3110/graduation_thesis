import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/app.dart';
import 'package:untitled1/cubit/app/app_config_bloc.dart';
import 'package:untitled1/firebase_options.dart';
import 'package:untitled1/ui/category/category_cubit.dart';
import 'package:untitled1/ui/home/home_cubit.dart';
import 'package:untitled1/ui/language/language_cubit.dart';
import 'package:untitled1/ui/profile/profile_cubit.dart';
import 'package:untitled1/ui/search/search_cubit.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';

void main() async{
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppConfigBloc()),
        BlocProvider(create: (_) => UserAuthenticationCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => CategoryCubit()),
        BlocProvider(create: (_) => SearchCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
