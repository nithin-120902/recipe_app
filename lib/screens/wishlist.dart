// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class WishList extends StatelessWidget {
  WishList({super.key});

  var list = [Colors.indigo,Colors.blue,Colors.green,Colors.yellow,Colors.orange,Colors.red,Colors.black,Colors.grey,Colors.lightBlue,Colors.redAccent,Colors.indigoAccent];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: const Text("Wish List"),
      ),
      body:Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,width:50,color: list[index],
            );
          },
        ),
      )
    );
  }
}