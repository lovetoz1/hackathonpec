import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobportal/pages/login/firstpage.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
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
                        GestureDetector(
                            
                            child: CircleAvatar(),
                          onTap: (){
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()), (route) => false);

                          },
                        
                        ),

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
