import 'package:flutter/material.dart';
import 'package:jobportal/pages/EmployerHomePage.dart';
import 'package:jobportal/pages/WorkerHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const EmployerHomePage(),
    );
  }
}