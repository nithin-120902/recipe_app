// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive_sample/service/model.dart';

import 'package:http/http.dart' as http;

//import '../service/model.dart';

class ApiDataRendering extends ChangeNotifier {


  bool homePageLoading = true;
  bool homePageError = false;
  bool searchPageLoading = true;
  bool searchPageError = false;
  List<Model> suggestionList = [];
  List history = [];
  List queryList = [];
  List<Model> searchList = [];

  appendSearchQuery(String query){
    queryList.insert(0, query);
  }

  getApiData() async {
    notifyListeners();
    try {
      homePageError=false;
      await Hive.initFlutter('searchHistory');
      Box box = await Hive.openBox('Box');
      if (box.toMap().isEmpty) {
        var url =
            "https://api.edamam.com/search?q=&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4&from=0&to=100&calories=591-722&health=alcohol-free";
        var response = await http.get(Uri.parse(url));
        Map json = jsonDecode(response.body);
        json['hits'].forEach((e) {
          Model model = Model(
              url: e['recipe']['url'],
              image: e['recipe']['image'],
              source: e['recipe']['source'],
              label: e['recipe']['label']);
          suggestionList.add((model));
        });
      } else {
        var keys = box.keys;
        Map map = {};
        int sum = 0;
        for (int value in box.values) {
          sum = sum + value;
        }
        for (var key in keys) {
          map[key] = ((box.get(key) / sum) * 100).toInt();
          if (!history.contains(key)) {
            history.add(key);
          }
        }
        for (var key in map.keys) {
          var url = "https://api.edamam.com/search?q=" +
              key +
              "&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=" +
              map[key].toString() +
              "&calories=591-722&health=alcohol-free";
          var response = await http.get(Uri.parse(url));
          Map json = jsonDecode(response.body);
          json['hits'].forEach((e) {
            Model model = Model(
                url: e['recipe']['url'],
                image: e['recipe']['image'],
                source: e['recipe']['source'],
                label: e['recipe']['label']);
            suggestionList.add((model));
          });
        }
      }
      homePageLoading = false;
      notifyListeners();
    } catch (e) {
      homePageLoading=false;
      homePageError=true;
      notifyListeners();
    }
  }

  getSearchQueryApiData() async{
    notifyListeners();
    try {
      searchPageError = false;
      searchList=[];
      var url = "https://api.edamam.com/search?q="
        +queryList.elementAt(0)
        +"&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=100&calories=591-722&health=alcohol-free";
      var response = await http.get(Uri.parse(url));
      Map json = jsonDecode(response.body);
      json['hits'].forEach((e) {
        Model model = Model(
            url: e['recipe']['url'],
            image: e['recipe']['image'],
            source: e['recipe']['source'],
            label: e['recipe']['label']);
        searchList.add((model));
      });
      //throw 'This is an error';
      searchPageLoading=false;
      notifyListeners();
    } catch (e) {
      searchPageError = true;
      searchPageLoading=false;
      notifyListeners();
    }
  }
}
