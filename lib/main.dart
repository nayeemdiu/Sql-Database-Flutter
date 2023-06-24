import 'package:flutter/material.dart';
import 'package:sqflite_database/sqflite_database_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app demo',
      theme: ThemeData(
      ),
      home: SqfliteDatabase(),
    );
  }
}