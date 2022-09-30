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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(),

                    ],
                  ),
                  Text("Find a Job", style: TextStyle(
                    fontStyle: GoogleFonts.poppins().fontStyle,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
