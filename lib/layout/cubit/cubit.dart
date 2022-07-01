import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/busines/busines_screen_screen.dart';
import 'package:newsapp/modules/science/science_Screen.dart';
import 'package:newsapp/modules/settings/settings_Screen.dart';
import 'package:newsapp/modules/sports/sport_Screen.dart';
import 'package:newsapp/shared/network/dio_helper.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeStatus> {
  ThemeCubit() : super(ThemeInitialState());
  static ThemeCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeAppMode({bool? formShared}) {
    isDark=!isDark;
    emit(NewsThemeModeState());
    // if (formShared != null) {
    //   isDark = formShared;
    //   emit(NewsThemeModeState());
    // } else {
    //   isDark = !isDark;
    //   CacheHelpper.putBoolean(key: 'isDark', value: isDark)
    //       .then((value) => {emit(NewsThemeModeState())});
    // }
  }
}

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    BusinesScreen(),
    SportScreen(),
    ScienceScreen(),

    // SettingScreen()
  ];
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_rounded), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    // BottomNavigationBarItem(icon:Icon(Icons.settings),label: "Settings")
  ];
  void changeBottomNAvBar(int index) {
    currentindex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(ChangeBottomNAvBArState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelpper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
      'country': 'eg',
      "category": 'business',
      "apiKey": 'bfc5a5d8aa434485a08c6132480555b4'
    })
        .then((value) => {
              business = value.data['articles'],
              print(business.length),
              emit(NewsGetBusinessSuccessState()),
            })
        .catchError((error) {
      print('Error Get Business ${error}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  //get Sport
  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportLoadingState());
    if (sports.length == 0) {
      DioHelpper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
        'country': 'eg',
        "category": 'sports',
        "apiKey": 'bfc5a5d8aa434485a08c6132480555b4'
      })
          .then((value) => {
                sports = value.data['articles'],
                print(sports.length),
                emit(NewsGetSportSuccessState()),
              })
          .catchError((error) {
        print('Error Get sports ${error}');
        emit(NewsGetSportErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  //get Science
  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelpper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
        'country': 'eg',
        "category": 'science',
        "apiKey": 'bfc5a5d8aa434485a08c6132480555b4'
      })
          .then((value) => {
                science = value.data['articles'],
                print(science.length),
                emit(NewsGetScienceSuccessState()),
              })
          .catchError((error) {
        print('Error Get science ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  //get search
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    // search=[];
    if (science.length == 0) {
      DioHelpper.getData(url: 'https://newsapi.org/v2/everything', query: {
        "q": '$value',
        "apiKey": 'bfc5a5d8aa434485a08c6132480555b4'
      })
          .then((value) => {
                search = value.data['articles'],
                print(search.length),
                emit(NewsGetSearchSuccessState()),
              })
          .catchError((error) {
        print('Error Get science ${error.toString()}');
        emit(NewsGetSearchErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }

// هنا معناها ان هدوس علي ال icon  ف هجيب الل sports
  void getSearch2(String value) {
    emit(NewsGetSearchLoadingState());
    // عشان الداتا تيجي مره واحده متحملش مع كل ضغطه علي الل icon  في BNB
    // ولكن هنا بعد ما جبت sports  انا مش هدخل داخل dio لا تساوي ال 0 لان فية داتا يعني هيعمل load مره واحده بسسس
    // الفديو 93 الدقيقه 45
    DioHelpper.getData(url: 'https://newsapi.org/v2/everything', query: {
      "q": '$value',
      "apiKey": 'bfc5a5d8aa434485a08c6132480555b4'
    }).then((value) {
//        print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error().toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
