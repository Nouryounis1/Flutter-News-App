import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/cubit/home_cubit/home_state.dart';
import 'package:news_app/layout/home_screen.dart';
import 'package:news_app/modules/profile/profile_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/trending/trending_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitalState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [TrendingScreen(), SearchScreen(), ProfileScreen()];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.home,
          size: 25.0,
        ),
        title: SizedBox.shrink()),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.search,
        size: 25.0,
      ),
      title: SizedBox.shrink(),
    ),

    BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 15.0,
        backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1620825937374-87fc7d6bddc2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80'),
      ),
      title: SizedBox.shrink(),
    ),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];
  int selectedIndex = 0;
  List<dynamic> everythng = [];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(NewsBottomNav());
  }

  void changeIcons(int index) {
    selectedIndex = index;

    emit(HomeIconsChanged());
  }

  void getEveryThing() {
    emit(NewsGetEverythingLoadingState());

    if (everythng.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'apiKey': '6eeb5b5a048b47da858d5a14010f6f70',
      }).then((value) {
        // print(value.data.toString());
        everythng = value.data['articles'];

        print(everythng[0]['description']);
        emit(NewsGetEverythingSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetEverythingErrorState(error.toString()));
      });
    } else {
      emit(NewsGetEverythingSuccessState());
    }
  }
}
