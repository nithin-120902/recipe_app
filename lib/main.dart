// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/home.dart';
import 'package:hive_sample/screens/homepageloading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageLoading>(create: (_) => HomePageLoading())
      ],
      child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Home()),
    );
  }
}

