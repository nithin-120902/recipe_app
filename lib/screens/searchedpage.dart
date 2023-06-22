// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/homepageloading.dart';
import 'package:hive_sample/screens/shimmerloading.dart';
import 'package:hive_sample/screens/webview.dart';
import 'package:provider/provider.dart';

class SearchedPage extends StatefulWidget {
  const SearchedPage({super.key});

  @override
  State<SearchedPage> createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {
  @override
  Widget build(BuildContext context) {
    final apiData = Provider.of<HomePageLoading>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Recipe App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiData.getSearchQueryApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoading();
          } else {
            return Container(
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
                        itemCount: apiData.searchList.length,
                        itemBuilder: (context, i) {
                          final x = apiData.searchList[i];
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
            );
          }
        },
      ),
    );
  }
}
