// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_sample/screens/apidatarendering.dart';
import 'package:hive_sample/screens/searchedpage.dart';
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
  Widget build(BuildContext context) {
    final history = context.watch<ApiDataRendering>().history;
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
                    searchHistory(_controller.value.text);
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
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      searchHistory(history.elementAt(index));
                    },
                    child: ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text(history.elementAt(index)),
                      trailing: Icon(Icons.arrow_outward_rounded),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  void searchHistory(String text) async {
    RegExp re = RegExp(r'^[ ]+$');
    if (text == '' || re.hasMatch(text)) {
      return;
    }
    await Hive.initFlutter('searchHistory');
    Box box = await Hive.openBox('Box');
    text = text.trim();
    if (box.get(text) == null) {
      box.put(text, 1);
    } else {
      dynamic k = box.get(text);
      box.delete(text);
      box.put(text, k + 1);
    }
    dynamic keys = box.keys;
    Map map = {};
    for (var i in keys) {
      map[i] = box.get(i);
    }
    Provider.of<ApiDataRendering>(context,listen:false).appendSearchQuery(text);
    Navigator.push(context,
              MaterialPageRoute(
                  builder:(context) => SearchedPage()));
  }
}
