import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          children: const [
            SizedBox(
              child: Text("Find a Job", style: TextStyle(

              ),)
            ),
          ],
        ),
      ),
    );
  }
}
