// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_sample/bloc/history/history_bloc.dart';
import 'dart:core';
import 'package:hive_sample/bloc/querypage/querypage_bloc.dart';
import 'package:hive_sample/screens/querypage.dart';
import 'package:hive_sample/components/shimmerloading.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  //Map map;
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(GetHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Column(
          children: [
            TextField(
              onSubmitted:(String value){
                final text = searchHistory(value);
                    if(text!=''){
                      context.read<QuerypageBloc>().add(GetQuery(text));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Querypage()));
                    }
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                fillColor: Colors.grey[300],
                filled: true,
                prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final text = searchHistory(_controller.value.text);
                    if(text!=''){
                      context.read<QuerypageBloc>().add(GetQuery(text));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Querypage()));
                    }
                  },
                ),
                label: Text("Search for Recipe...."),
                labelStyle: TextStyle(letterSpacing: 1),
              ),
              controller: _controller,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Expanded(
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if(state is HistoryLoading){
                    return ShimmerLoading();
                  }
                  if(state is HistoryFailed){
                    return Center(child:Text("Error"));
                  }
                  if(state is HistorySuccess){
                    return ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            context.read<QuerypageBloc>().add(GetQuery(state.list[index]));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Querypage()));
                          },
                          child: ListTile(
                              leading: Icon(Icons.access_time),
                              title: Text(state.list[index]),
                              trailing: Icon(Icons.arrow_outward_rounded),
                          ),
                    );
                      },
                    );
                  }
                  else{
                    return Center(child:Text("Loading...."));
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  String searchHistory(String text){
    RegExp re = RegExp(r'^[ ]+$');
    if (text == '' || re.hasMatch(text)) {
      return '';
    }
    return text;
  }
}
