// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive_sample/screens/home.dart';
import 'package:hive_sample/service/model.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_spinkit/flutter_spinkit.dart';



//import '../service/model.dart';

class HomePageLoading extends StatefulWidget {
  const HomePageLoading({super.key});

  @override
  State<HomePageLoading> createState() => _HomePageLoadingState();
}

class _HomePageLoadingState extends State<HomePageLoading> {
  
  List<Model> list = [];

  getApiData() async {
    String query='';
    String bound="100";
    await Hive.initFlutter('search_history');
    Box box = await Hive.openBox('Box');
    if (box.toMap() == {}) {
      query='';
      bound="100";
      var url =
      "https://api.edamam.com/search?q="+query+"&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to="+bound+"&calories=591-722&health=alcohol-free";
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
      Map map={};
      int sum=0;
      for(int value in box.values){
        sum=sum+value;
      }
      for(var key in keys){
        map[key]=((box.get(key)/sum)*100).toInt();
      }
      for(var key in map.keys){
       var url =
      "https://api.edamam.com/search?q="+key+"&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to="+map[key].toString()+"&calories=591-722&health=alcohol-free";
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home(list: list)));
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitHourGlass(
          color: Colors.deepPurpleAccent,
          size: 100,
        ),
      ),
    );
  }
}
