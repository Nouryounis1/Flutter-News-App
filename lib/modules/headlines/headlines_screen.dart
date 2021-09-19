import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/home_cubit/home_cubit.dart';
import 'package:news_app/cubit/home_cubit/home_state.dart';

class HeadlinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = HomeCubit.get(context).everythng;
        return Scaffold(
          appBar: AppBar(
            title: Text('Headlines'),
          ),
          body: articleBuilder(list),
        );
      },
    );
  }
}
