// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/webview.dart';

import '../service/model.dart';

class DisplayList extends StatelessWidget {
  final List<Model> list;
  const DisplayList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              primary: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Webview(url: x.url)));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(
                              image: NetworkImage(x.image.toString()),
                              fit: BoxFit.contain)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(color:Colors.black.withOpacity(0.5),onPressed: (){}, icon: Icon(Icons.format_list_bulleted_add)),
                              IconButton(color:Colors.black.withOpacity(0.5),onPressed: (){}, icon: Icon(Icons.favorite_border)),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0))),
                            padding: EdgeInsets.all(3),
                            height: 50,
                            child: Center(
                                child: Text(x.label.toString(),
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ],
                      )),
                );
              },
            ),
          )
        ]));
  }
}
