import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobCard extends StatelessWidget {
  const JobCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          // color: Colors.blueAccent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //jobtitle and pay
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Job Title",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("₹200/hr", style: GoogleFonts.notoSansMono(fontWeight: FontWeight.bold, fontSize: 16),),
                ),
              )
            ],
          ),

          //skills required
          Row(
            children: const[
              SkillChip(skillName: "Electrician"),
            ],
          ),

          //location
          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.location_pin, size: 15,),
              SizedBox(width: 5,),
              Text("Chandigarh, India", style: GoogleFonts.poppins(),)
            ],
          ),

          SizedBox(height: 10,),
          Row(
            children: [
              Icon(Icons.date_range, size: 15,),
              SizedBox(width: 5,),
              Text("10 Dec - 20 Dec", style: GoogleFonts.poppins(),)
            ],
          ),
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String skillName;
  const SkillChip({required this.skillName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(skillName, style: GoogleFonts.lato(fontSize: 10),),
      );
  }
}

