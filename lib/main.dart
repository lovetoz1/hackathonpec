import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobportal/ProfilePage.dart';
import 'package:jobportal/firebase_options.dart';
import 'package:jobportal/pages/WorkerHomePage.dart';
import 'package:jobportal/pages/login/firstpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
      home:  LoginScreen(),
      // home: ProfilePage(),
    );
  }
}