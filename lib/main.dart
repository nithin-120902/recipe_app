// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_sample/screens/apidatarendering.dart';
import 'package:hive_sample/screens/titlepage.dart';
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
        ChangeNotifierProvider<ApiDataRendering>(create: (_) => ApiDataRendering())
      ],
      child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: TitlePage()),
    );
  }
}

