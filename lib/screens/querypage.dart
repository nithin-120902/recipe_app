// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_sample/bloc/querypage/querypage_bloc.dart';
import 'package:hive_sample/components/displaylist.dart';
import 'package:hive_sample/components/shimmerloading.dart';

class Querypage extends StatefulWidget {
  const Querypage({super.key});

  @override
  State<Querypage> createState() => _QuerypageState();
}

class _QuerypageState extends State<Querypage> {

  @override
  void initState() {
    super.initState();
    context.read<QuerypageBloc>().add(FetchDataEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Icon(Icons.restaurant_menu),
          SizedBox(
            width: 5,
          ),
          Text("CookOo"),
        ]),
      ),
      body:BlocBuilder<QuerypageBloc,QuerypageState>(
        builder: (context,state){
          if(state is QuerypageLoading){
            return ShimmerLoading();
          }
          if(state is QuerypageFailed){
            return Center(child:Text("Error"));
          }
          if(state is QuerypageSuccess){
            final dataFetched = state.dataFetched;
            return DisplayList(list: dataFetched);
          }
          else{
            return Center(child:Text("Loading....."));
          }
        }
      ));
  }
}
