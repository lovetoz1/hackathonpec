import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => PProfilePageState();
}

class PProfilePageState extends State<ProfilePage> {



  @override
  Widget build(BuildContext context) {
    List<Widget> skills=[];



    skills.add(Skills(myskill: "Plumber"));
    skills.add(Skills(myskill: "Plumber"));


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 30,),
          ListTile(leading: Icon(Icons.notifications_active_outlined),),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12)
            ),
            child: ListTile(
              subtitle: Text("English",style: TextStyle(color: Colors.grey),),
              title: Text("Sushant ",style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: CircleAvatar(),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            alignment: Alignment.topLeft,
            child: Text("My skills"),
          ),
          Center(child: Container(
            // height: 90,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.blue

            ),
            padding: EdgeInsets.fromLTRB(2,3,0,0),
            child: Row(
              children: skills,
            ),
          )),
          SizedBox(height: 30,),

          Container(margin: EdgeInsets.all(30),

          ),


        ]),
      ),
    );
  }
}
class Skills extends StatelessWidget {
  Skills({Key? key, required this.myskill}) : super(key: key);
final String myskill;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue,

        ),
        child: Padding(

          padding: const EdgeInsets.all(8.0),
          child: Text(myskill,style: TextStyle(fontSize: 20.0,color: Colors.white),),
        ),
      ),
    );
  }
}
