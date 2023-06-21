// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive_sample/service/model.dart';

import 'package:http/http.dart' as http;

//import '../service/model.dart';

class HomePageLoading extends ChangeNotifier {
  bool loading = true;

  List<Model> list = [];

  getApiData() async {
    notifyListeners();
    print("Hii");
    loading = false;
    await Hive.initFlutter('search_history');
    Box box = await Hive.openBox('Box');
    if (box.toMap() == {}) {
      var url =
          "https://api.edamam.com/search?q=&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=100calories=591-722&health=alcohol-free";
      var response = await http.get(Uri.parse(url));
      Map json = jsonDecode(response.body);
      json['hits'].forEach((e) {
        Model model = Model(
            url: e['recipe']['url'],
            image: e['recipe']['image'],
            source: e['recipe']['source'],
            label: e['recipe']['label']);
        list.add((model));
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
          list.add((model));
        });
      }
    }
    print("Nithin");
    print(list);
    notifyListeners();
  }
}
