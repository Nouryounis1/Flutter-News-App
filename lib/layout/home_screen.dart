import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/home_cubit/home_cubit.dart';
import 'package:news_app/cubit/home_cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: HomeCubit.get(context)
                .screens[HomeCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                HomeCubit.get(context).changeBottomNavBar(index);
              },
              items: HomeCubit.get(context).bottomItems,
              currentIndex: HomeCubit.get(context).currentIndex,
            ),
          );
        });
  }
}
