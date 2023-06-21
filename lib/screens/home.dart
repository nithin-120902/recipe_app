// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/homepageloading.dart';
import 'package:hive_sample/screens/search.dart';
import 'package:hive_sample/screens/webview.dart';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Map> history() async {
    await Hive.initFlutter('search_history');
    Box box = await Hive.openBox('Box');
    var keys = box.keys;
    Map map = {};
    for (var i in keys) {
      map[i] = box.get(i);
    }
    return map;
  }

  List completed = [];
  bool notInCompleted(int ran) {
    for (var i in completed) {
      if (i == ran) {
        return true;
      }
    }
    return false;
  }

  int random(int index,int len) {
    var ran = Random();
    int rn = ran.nextInt(len);
    while (notInCompleted(rn)) {
      var ran = Random();
      int rn = ran.nextInt(len);
    }
    return rn;
  }
  //var apiData;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final apiData = Provider.of<HomePageLoading>(context, listen: false);
      apiData.getApiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiData = context.watch<HomePageLoading>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Row(children: [
          Icon(Icons.restaurant_menu),
          SizedBox(
            width: 5,
          ),
          Text("Recipe"),
        ]),
      ),
      body: apiData.list==[] ? Center(child:CircularProgressIndicator()) : Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        primary: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                        itemCount: apiData.list.length,
                        itemBuilder: (context, i) {
                          final x =
                              apiData.list[random(i, apiData.list.length)];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Webview(url: x.url)));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(x.image.toString()),
                                        fit: BoxFit.contain)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0))),
                                      padding: EdgeInsets.all(3),
                                      height: 50,
                                      child: Center(
                                          child: Text(x.label.toString(),
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    )
                  ]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map map = await history();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Search(
                        map: map,
                      )));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
