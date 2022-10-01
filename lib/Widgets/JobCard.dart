import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobportal/Model/Job.dart';
import 'package:jobportal/pages/JobDetailPage.dart';
import 'package:page_transition/page_transition.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  const JobCard({required this.job, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped");
        Navigator.of(context).push(PageTransition(child: JobDetailPage(job: job,), type: PageTransitionType.rightToLeft));
      },
      child: Container(
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
                  job.title,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text("₹${job.wagePerHour}/hr", style: GoogleFonts.notoSansMono(fontWeight: FontWeight.bold, fontSize: 16),),
                  ),
                )
              ],
            ),

            //skills required
            Row(
              children:[
                SkillChip(skillName: job.workerType),
              ],
            ),

            //location
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.location_pin, size: 15,),
                SizedBox(width: 5,),
                Text(job.location, style: GoogleFonts.poppins(),)
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

