// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/apidatarendering.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiDataRendering>(context, listen: false).getSearchQueryApiData();
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
      body: Consumer<ApiDataRendering>(builder: (context, state, _) {
        if (Provider.of<ApiDataRendering>(context).searchPageLoading) {
          return ShimmerLoading();
        } else if (Provider.of<ApiDataRendering>(context).searchPageError) {
          return Center(
            child: Text(
              'Error',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          );
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
                      itemCount: Provider.of<ApiDataRendering>(context)
                          .searchList.length,
                      itemBuilder: (context, i) {
                        final x = Provider.of<ApiDataRendering>(context)
                            .searchList[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Webview(url: x.url)));
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
      }),
    );
  }
}
