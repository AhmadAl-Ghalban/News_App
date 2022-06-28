import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/component/components.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  onPressed: () {
navigateTo(context, SearchScreent());

                  },
                  icon: Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {
                    ThemeCubit.get(context).changeAppMode();
                  },
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNAvBar(index);
            },
          ),
          body: cubit.screens[cubit.currentindex],
        );
      },
    );
  }
}
