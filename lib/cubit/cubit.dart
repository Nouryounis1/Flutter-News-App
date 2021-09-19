import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitalState());
  static NewsCubit get(context) => BlocProvider.of(context);

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> health = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '6eeb5b5a048b47da858d5a14010f6f70',
    }).then((value) {
      // print(value.data.toString());
      business = value.data['articles'];

      print(business[0]['description']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '6eeb5b5a048b47da858d5a14010f6f70',
      }).then((value) {
        // print(value.data.toString());
        sports = value.data['articles'];

        print(sports[0]['description']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'c1ea1c044c214d93bf8725e972cc1ba0',
      }).then((value) {
        // print(value.data.toString());
        science = value.data['articles'];

        print(science[0]['description']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getHealth() {
    emit(NewsGetHealthLoadingState());

    if (health.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'health',
        'apiKey': '6eeb5b5a048b47da858d5a14010f6f70',
      }).then((value) {
        // print(value.data.toString());
        health = value.data['articles'];

        print(health[0]['description']);
        emit(NewsGetHealthSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetHealthErrorState(error.toString()));
      });
    } else {
      emit(NewsGetHealthSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '6eeb5b5a048b47da858d5a14010f6f70',
    }).then((value) {
      // print(value.data.toString());
      search = value.data['articles'];

      print(search[0]['description']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
