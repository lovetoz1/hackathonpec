import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobportal/Widgets/CustomIconButton.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({Key? key}) : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, bottom: 20),
            child: CustomIconButton(
                icon: Icons.arrow_back_outlined,
                onPress: () => {Navigator.of(context).pop()}),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              children: [
                //job title
                Center(
                  child: Text(
                    "Building House",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    "Electrician",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_sharp),
                          Text("10/18", style: GoogleFonts.poppins(
                            fontSize: 18,
                              color: Colors.white
                          )),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money),
                          Text("₹200/hr", style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white
                          )),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_pin, size: 15,),
                        SizedBox(width: 5,),
                        Text("Chandigarh, India", style: GoogleFonts.poppins(fontSize: 18),)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.date_range, size: 15,),
                        SizedBox(width: 5,),
                        Text("10 Dec,2022 - 1 Jan,2023", style: GoogleFonts.poppins(fontSize: 18),)
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                //job description
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffe7e7e7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                          CustomIconButton(
                              icon: Icons.volume_up_sharp, onPress: () => {})
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const DescriptionPoints(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"),
                      const DescriptionPoints(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"),
                      const DescriptionPoints(
                          text:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Apply Now",
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, padding: EdgeInsets.all(8)),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionPoints extends StatelessWidget {
  final String text;
  const DescriptionPoints({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle,
            size: 12,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
              child: Text(
            text,
            style: GoogleFonts.poppins(),
          ))
        ],
      ),
    );
  }
}
