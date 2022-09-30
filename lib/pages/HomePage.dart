import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobportal/Widgets/JobCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //upper portion of page containing user info and search box
          Container(
            padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
            decoration:const BoxDecoration(
              color: Color(0xffF3F5F7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 10,),
                        Text("Sushant Mishra", style: GoogleFonts.poppins(fontSize: 20))
                      ],
                    ),
                    const Icon(Icons.notifications, size: 30,)
                  ],
                ),
                const SizedBox(height: 20,),
                Text("Find a Job", style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 10,),
                      Flexible(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.lato(fontSize: 20),
                          )
                      ),
                    ],
                  ),
                )
              ],
            )
          ),

          //job list rendering
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, ind) {
                  return const JobCard();
                },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
