// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_sample/bloc/querypage/querypage_bloc.dart';
import 'package:hive_sample/screens/shimmerloading.dart';
import 'package:hive_sample/screens/webview.dart';

class Querypage extends StatefulWidget {
  const Querypage({super.key});

  @override
  State<Querypage> createState() => _QuerypageState();
}

class _QuerypageState extends State<Querypage> {

  @override
  void initState() {
    super.initState();
    context.read<QuerypageBloc>().add(FetchDataEvent());
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
      body:BlocBuilder<QuerypageBloc,QuerypageState>(
        builder: (context,state){
          if(state is QuerypageLoading){
            return ShimmerLoading();
          }
          if(state is QuerypageFailed){
            return Center(child:Text("Error"));
          }
          if(state is QuerypageSuccess){
            final dataFetched = state.dataFetched;
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
                      itemCount: dataFetched.length,
                      itemBuilder: (context, i) {
                        final x = dataFetched[i];
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
          else{
            return Center(child:Text("Loading....."));
          }
        }
      ));
    //   body: Consumer<ApiDataRendering>(builder: (context, state, _) {
    //     if (Provider.of<ApiDataRendering>(context).searchPageLoading) {
    //       return ShimmerLoading();
    //     } else if (Provider.of<ApiDataRendering>(context).searchPageError) {
    //       return Center(
    //         child: Text(
    //           'Error',
    //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    //         ),
    //       );
    //     } else {
    //       return Container(
    //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    //         child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               Expanded(
    //                 child: GridView.builder(
    //                   physics: ScrollPhysics(),
    //                   shrinkWrap: true,
    //                   primary: true,
    //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                       crossAxisCount:
    //                           MediaQuery.of(context).size.width ~/ 150,
    //                       crossAxisSpacing: 15,
    //                       mainAxisSpacing: 15),
    //                   itemCount: Provider.of<ApiDataRendering>(context)
    //                       .searchList.length,
    //                   itemBuilder: (context, i) {
    //                     final x = Provider.of<ApiDataRendering>(context)
    //                         .searchList[i];
    //                     return InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => Webview(url: x.url)));
    //                       },
    //                       child: Container(
    //                           decoration: BoxDecoration(
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(20.0)),
    //                               image: DecorationImage(
    //                                   image: NetworkImage(x.image.toString()),
    //                                   fit: BoxFit.contain)),
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             children: [
    //                               Container(
    //                                 decoration: BoxDecoration(
    //                                     color: Colors.black.withOpacity(0.5),
    //                                     borderRadius: BorderRadius.only(
    //                                         bottomLeft: Radius.circular(20.0),
    //                                         bottomRight:
    //                                             Radius.circular(20.0))),
    //                                 padding: EdgeInsets.all(3),
    //                                 height: 50,
    //                                 child: Center(
    //                                     child: Text(x.label.toString(),
    //                                         style: TextStyle(
    //                                             color: Colors.white))),
    //                               ),
    //                             ],
    //                           )),
    //                     );
    //                   },
    //                 ),
    //               )
    //             ]),
    //       );
    //     }
    //   }),
    // );
  }
}
