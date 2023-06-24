import 'package:flutter/material.dart';

class SqfliteDatabase extends StatefulWidget {
  const SqfliteDatabase({Key? key}) : super(key: key);

  @override
  State<SqfliteDatabase> createState() => _SqfliteDatabaseState();
}

class _SqfliteDatabaseState extends State<SqfliteDatabase> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar: AppBar(title: Text('SQL DATABASE'),),

    );
  }
}
