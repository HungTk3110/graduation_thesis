import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/ui/home/home_cubit.dart';
import 'package:untitled1/ui/user_authentication/user_authentication_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
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
