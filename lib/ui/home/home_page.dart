import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/ui/home/components/nav_drawer.dart';
import 'package:untitled1/ui/home/home_cubit.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CupertinoButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          child: SizedBox(
            width: 24.r,
            height: 24.r,
            child: SvgPicture.asset(
              'assets/icon/menu.svg',
            ),
          ),
        ),
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Text(
                'Hello, ${state.userLocal?.userName }'
            );
          },
        )
      ],
    );
  }
}
