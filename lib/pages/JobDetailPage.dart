import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobportal/Model/Job.dart';
import 'package:jobportal/Widgets/CustomIconButton.dart';
import 'package:translator/translator.dart';

class JobDetailPage extends StatefulWidget {
  final JobModel job;
  const JobDetailPage({ required this.job, Key? key}) : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {

  void validateAndSave() async {
    if(UserName.length <= 4){
      setState(() {
        errMsgForm = "User Name must me 4 length";
      });
      return;
    }

    setState(() {
      errMsgForm = "";
      callingApi = true;
    });

    try{

      Response res = await _api.post(endpoint: '/users/create-account', data: {
        "name":UserName,
        "userType":UserType,
        "workerTag":WorkerType,
      });
      print(res.data);
      if(UserType == "worker"){
        print("worker");
        Navigator.of(context).pushAndRemoveUntil(PageTransition(child: const WorkerHomePage(), type: PageTransitionType.rightToLeft), (route) => false);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(PageTransition(child: const EmployerHomePage(), type: PageTransitionType.rightToLeft), (route) => false);
      }
    }
    on DioError catch(e){
      print(e.response);
    }
  }

  bool _isLoading = false;


  FlutterTts flutterTts = FlutterTts();
  final translator = GoogleTranslator();

  void speakDescription() async {

    List<dynamic> languages = await flutterTts.getLanguages;
    print(languages);
    print("function called speak");
    await flutterTts.setLanguage("hi-IN");

    translator.translate(widget.job.description, from: 'en', to: 'hi').then((data) async {
      await flutterTts.speak(data.text);
    });

  }

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
                    widget.job.title,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    widget.job.workerType,
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
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_sharp),
                          Text("${widget.job.appliedWorkersCount}/${widget.job.noOfWorkers}", style: GoogleFonts.poppins(
                            fontSize: 18,
                              color: Colors.white
                          )),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money),
                          Text("₹${widget.job.wagePerHour}/hr", style: GoogleFonts.poppins(
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
                        Text(widget.job.location, style: GoogleFonts.poppins(fontSize: 18),)
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
                              icon: Icons.volume_up_sharp, onPress: speakDescription
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DescriptionPoints(
                          text:
                          widget.job.description),
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
                    width: MediaQuery. of(context). size. width*0.9,
                    child: Center(
                      child:   MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });


                          // Future.delayed(Duration(seconds: 2), () {
                          //   setState(() {
                          //     _isLoading = false;
                          //   });
                          //
                          //
                          // });
                        },
                        color: _isLoading ? Colors.black : Colors.green,
                        shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(5)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        child: _isLoading  ? Container(

                          child: Text("Applied",   style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                        ) :
                        Text("Apply Now",   style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                      ),
                      // child: Text(
                      //   "Apply Now",
                      //   style: GoogleFonts.poppins(fontSize: 20),
                      // ),

                    ),
                  ),
                  // style: ElevatedButton.styleFrom(
                  //     primary: Colors.black, padding: EdgeInsets.all(8)),
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
