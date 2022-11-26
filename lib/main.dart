import 'package:flutter/material.dart';
import 'package:week_16_objectbox/NotePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'База данных object',
        home: Scaffold(
          body: NotesPage(),
        ),
      );
    }
  }
