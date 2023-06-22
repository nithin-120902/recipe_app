// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/apidatarendering.dart';
import 'package:hive_sample/screens/search.dart';
import 'package:hive_sample/screens/shimmerloading.dart';
import 'package:hive_sample/screens/webview.dart';
// import 'package:hive_sample/screens/webview.dart';
import 'dart:core';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiDataRendering>(context, listen:false).getApiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Row(children: [
          Icon(Icons.restaurant_menu),
          SizedBox(
            width: 5,
          ),
          Text("CookOo"),
        ]),
      ),
      body: Provider.of<ApiDataRendering>(context).homePageLoading
          ? ShimmerLoading()
          : Provider.of<ApiDataRendering>(context).homePageError
              ? Center(
                  child: Text(
                    'Error',
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(
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
                          crossAxisCount:
                              MediaQuery.of(context).size.width ~/ 150,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemCount: Provider.of<ApiDataRendering>(context).suggestionList.length,
                      itemBuilder: (context, i) {
                        final x = Provider.of<ApiDataRendering>(context).suggestionList[i];
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
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Search()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}