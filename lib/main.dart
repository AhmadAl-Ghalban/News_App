// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/layout/newsapp_layout.dart';
import 'package:newsapp/shared/block_Observer.dart';
import 'package:newsapp/shared/network/dio_helper.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';

void main()async {

  BlocOverrides.runZoned(
    () async {
      //بتاكد انو كل اشي هون في الميثود خلصت وبعدين يفتح الابلكشين
        WidgetsFlutterBinding.ensureInitialized();

      DioHelpper.init();
    await CacheHelpper.init();
          bool? isDark=CacheHelpper.getBoolean(key: 'isDark');


      runApp(MyApp(true));
                NewsCubit();

    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
final bool isDark;
MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers: [
        BlocProvider(
            create: (context) => NewsCubit()..getBusiness()..getScience()..getSports()),
               BlocProvider(
            create: (context) => ThemeCubit()..changeAppMode())
           
      ],
      // create: (context) =>NewsCubit()..changeAppMode(formShared: isDark)..getBusiness()..getScience()..getSports() ,
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {
          
        },
        builder: (context,state){
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.white,
                  elevation: 0.0),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.redAccent,
                  backgroundColor: Colors.white
                  
                  ),
                    textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.w600)
          
                  ),
                  ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                backgroundColor: HexColor('333739'),
                elevation: 0.0
                ),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor:  Colors.red,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,backgroundColor: HexColor('333739'),
                  ),
                  textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w600)
          
                  ),
          ),
          // themeMode: ThemeMode.dark,
                    themeMode:ThemeCubit.get(context).isDark==true? ThemeMode.light:ThemeMode.dark,

          home: NewsLayout(),
        );

        },
      ),
    );
  }
}
