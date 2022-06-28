import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/shared/component/components.dart';

class SearchScreent extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
listener: (context, state) {
  
},
    builder: (context, state){

      var list =NewsCubit.get(context).search;
return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value) {
                                NewsCubit.get(context).getSearch2(value);

              },
controller: searchController,
keyboardType: TextInputType.text,
validator:( value) {
                  if (value!.isEmpty) {
                    return 'search must not be empty';
                  }
    
                  return null;
                } ,
                decoration: InputDecoration(
label: Text('Search'),
          border: OutlineInputBorder(),

                  prefixIcon: Icon(Icons.search)
                ),
            )
          ),
          Expanded(child: articleBuilder(list, context,isSearch: true))
        ]),
      );

    }
    );
  }
}
/*
defultTextField(

                controller: searchController,
                type: TextInputType.text,
                text: 'Search',
                prefixIcon: Icons.search,
              onChange: (value){
                NewsCubit.get(context).getSearch2(value);
              },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'search must not be empty';
                  }
    
                  return null;
                }),
*/