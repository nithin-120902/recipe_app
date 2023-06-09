// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/webview.dart';

class SearchedPage extends StatefulWidget {
  List list;
  Map map;
  SearchedPage({super.key,required this.map,required this.list});

  @override
  State<SearchedPage> createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {

  List completed=[];
  bool notInCompleted(int ran){
    for(var i in completed){
      if(i==ran){
        return true;
      }
    }
    return false;
  }

  int random(int index){
    var ran =Random();
    int rn = ran.nextInt(widget.list.length);
    while(notInCompleted(rn)){
      var ran =Random();
      int rn = ran.nextInt(widget.list.length);
    }
    return rn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Recipe App"),
        centerTitle: true,
      ),
      body: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: widget.list.length,
        itemBuilder: (context, i) {
          final x = widget.list[random(i)];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Webview(url: x.url)));
            },
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(x.image.toString()),
                        fit: BoxFit.contain)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 50,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: Text(x.label.toString(),
                              style: TextStyle(color: Colors.white))),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}