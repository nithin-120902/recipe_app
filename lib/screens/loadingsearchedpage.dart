// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_sample/service/model.dart';
import 'package:hive_sample/screens/searchedpage.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSearchedPage extends StatefulWidget {
  Map map;
  String search;
  LoadingSearchedPage({super.key, required this.search, required this.map});

  @override
  State<LoadingSearchedPage> createState() => _LoadingSearchedPageState();
}

class _LoadingSearchedPageState extends State<LoadingSearchedPage> {
  getApiData(search) async {
    List<Model> list = [];
    var response = await http.get(Uri.parse(
        "https://api.edamam.com/search?q=$search&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=100&calories=591-722&health=alcohol-free"));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']);
      setState(() {
        list.add((model));
      });
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SearchedPage(list: list, map: widget.map)));
  }

  @override
  void initState() {
    super.initState();
    getApiData(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitHourGlass(color: Colors.deepPurpleAccent, size: 100),
      ),
    );
  }
}
