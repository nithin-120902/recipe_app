import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/home.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage()))); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,child:Image.asset('assets/logo.jpg'),);
  }
}