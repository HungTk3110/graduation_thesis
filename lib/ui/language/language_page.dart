import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/cubit/app/app_config_bloc.dart';
import 'package:untitled1/generated/l10n.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/ui/language/language_cubit.dart';
import 'package:untitled1/utils/locale_extension.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late AppConfigBloc _appConfigBloc;

  @override
  void initState() {
    _appConfigBloc = BlocProvider.of<AppConfigBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(_appConfigBloc.state.locale),
      child: Builder(
        builder: (context) {
          LanguageCubit languageCubit = BlocProvider.of<LanguageCubit>(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  AppNavigator.pop();
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              title: const Text('Language'),
              actions: [
                CupertinoButton(
                  onPressed: () {
                        _appConfigBloc.add(UpdateLocaleEvent(
                            locale: languageCubit.state));
                    AppNavigator.pop();
                  },
                  child: const Icon(
                      Icons.check
                  ),
                )
              ],
            ),
            body: _buildBodyWidget(languageCubit),
          );
        }
      ),
    );
  }

  Widget _buildBodyWidget(LanguageCubit languageCubit) {
    return
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: BlocBuilder<LanguageCubit, Locale>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: S.delegate.supportedLocales.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        languageCubit.updateLanguageSelection(
                            S.delegate.supportedLocales[index]);
                      },
                      child: S.delegate.supportedLocales[index] == state
                          ? itemSelected(state, index)
                          : itemLanguage(state, index),
                    );
                  },
                );
              },
            ),
          );
  }

  Widget itemSelected(Locale state, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff0AD0FF),
            Color(0xffC84CFF),
          ],
        ),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.r),
        child: Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            children: [
              Image.asset(
                S.delegate.supportedLocales[index].logo,
                height: 40.r,
                width: 40.r,
              ),
              16.horizontalSpace,
              Expanded(
                child: Text(S.delegate.supportedLocales[index].getLocaleName,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.r,
                        fontWeight: FontWeight.w500)),
              ),
              Icon(
                Icons.check,
                size: 30.r,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget itemLanguage(Locale state, int index) {
    return Padding(
      padding: EdgeInsets.all(2.r),
      child: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        decoration: BoxDecoration(
          color: const Color(0xff2B2C2E),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          children: [
            Image.asset(
              S.delegate.supportedLocales[index].logo,
              height: 40.r,
              width: 40.r,
            ),
            16.horizontalSpace,
            Expanded(
              child: Text(S.delegate.supportedLocales[index].getLocaleName,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.r,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

}
