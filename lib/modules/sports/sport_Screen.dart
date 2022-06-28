import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/component/components.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
        
      },
      builder:(context,state){
        var list =NewsCubit.get(context).sports;
        return articleBuilder(list,context);
      }
      
    );
  }
}
