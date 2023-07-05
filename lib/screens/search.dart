// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:hive_sample/bloc/querypage/querypage_bloc.dart';
import 'package:hive_sample/screens/querypage.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  //Map map;
  Search({super.key});

  final _controller = TextEditingController();

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
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                fillColor: Colors.grey[300],
                filled: true,
                prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //Navigator.popAndPushNamed(context, "home");
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
    // await Hive.initFlutter('searchHistory');
    // Box box = await Hive.openBox('Box');
    // text = text.trim();
    // if (box.get(text) == null) {
    //   box.put(text, 1);
    // } else {
    //   dynamic k = box.get(text);
    //   box.delete(text);
    //   box.put(text, k + 1);
    // }
    // dynamic keys = box.keys;
    // Map map = {};
    // for (var i in keys) {
    //   map[i] = box.get(i);
    // }
    return text;
  }
}
