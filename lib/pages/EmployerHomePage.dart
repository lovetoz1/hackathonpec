import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jobportal/Api/Api.dart';
import 'package:jobportal/Model/Job.dart';
import 'package:jobportal/Widgets/CustomDropdown.dart';

import '../Widgets/JobCard.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({Key? key}) : super(key: key);

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  List<String> empTypes = ["Labourer", "Electrician", "Carpenter"];
  int navIndex = 0;
  bool callingFetchJobApi = false;
  bool callingCreateJobApi = false;

  Api _api = Api();

  @override
  void initState() {
    fetchPostedJobList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex,
        onTap: (ind) {
          setState(() {
            navIndex = ind;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: 'New Job',
          ),
        ],
      ),
      body: navIndex == 0 ? getPostedJobsList() : createNewPost(),
    );
  }

  List<JobModel> jobs = [];

  void fetchPostedJobList() async {
    setState(() {
      callingFetchJobApi = true;
    });
    try{
      Response res = await _api.get(endpoint: "/jobs/employer/list");
      print(res.data["jobs"]);
      List<dynamic> response = res.data["jobs"];

      print(response);
      List<JobModel> tempJobs = [];
      response.forEach((job) {
        JobModel tempjob = JobModel(title: job["jobTitle"], description: job["description"], location: job["location"], noOfWorkers: job["totalWorkersRequired"], wagePerHour: job["payPerHour"], fromDate: DateTime.parse(job["startsOn"]), toDate: DateTime.parse(job["endsOn"]), workerType: job["workerTagRequired"], jobId: job["jobId"],
        appliedWorkersCount: job["appliedWorkersCount"]);
        tempJobs.add(tempjob);
      });

      setState(() {
        jobs = tempJobs;
        callingFetchJobApi = false;
      });
    }
    on DioError catch (e){
      print(e.response);
      setState(() {
        callingFetchJobApi = false;
      });
    }
  }

  Widget getPostedJobsList() {
    return Column(
      children: [
        Container(
            padding:
                const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xffF3F5F7),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Posted Jobs",
                  style: GoogleFonts.poppins(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Expanded(
          child: callingFetchJobApi ? Center(child: CircularProgressIndicator(),) : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, ind) {
              return JobCard(job: jobs[ind],);
            },
            itemCount: jobs.length,
          ),
        )
      ],
    );
  }

  DateTime fromDate = DateTime.now(), toDate = DateTime.now();
  String jobTitle = "";
  String jobDescription = "";
  String location = "";
  int noOfWorkers = 0;
  int wagePerHour = 0;
  String workerType = "";
  String errMsgForm = "";

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));
    return picked;
  }

  void pickFromDate() async {
    DateTime? picked = await _selectDate(context);
    if (picked != null) {
      setState(() {
        fromDate = picked;
      });
    }
  }

  void pickToDate() async {
    DateTime? picked = await _selectDate(context);
    if (picked != null) {
      setState(() {
        toDate = picked;
      });
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey();


  void validateAndSave() async {
    if (jobTitle.length < 4) {
      setState(() {
        errMsgForm = "Job Title length must be 4";
      });
      return;
    }

    if (jobDescription.length < 20) {
      setState(() {
        errMsgForm = "Job description length must be 20";
      });
      return;
    }

    if (location.length < 4) {
      setState(() {
        errMsgForm = "location length must be 4";
      });
      return;
    }

    if (noOfWorkers == 0) {
      setState(() {
        errMsgForm = "Enter no of workers";
      });
      return;
    }

    if (wagePerHour < 100) {
      setState(() {
        errMsgForm = "Minimum wage per hour allowed Rs100";
      });
      return;
    }

    if (toDate.isBefore(fromDate)) {
      setState(() {
        errMsgForm = "To date should be greater than from date";
      });
      return;
    }

    setState(() {
      errMsgForm = "";
      callingCreateJobApi = true;
    });

    print("all set");

    try{

      Response res = await _api.post(endpoint: '/jobs/employer/create', data: {
        "jobTitle":jobTitle,
        "description":jobDescription,
        "totalWorkersRequired":noOfWorkers,
        "location":location,
        "payPerHour":wagePerHour,
        "startsOn":fromDate.toIso8601String(),
        "endsOn": toDate.toIso8601String(),
        "hoursPerDay":10,
        "workerTagRequired":workerType,
      });

      //if request was successful
      print(res.data);
      fetchPostedJobList();
      setState(() {
        navIndex = 0;
        callingCreateJobApi = false;
      });
    }
    on DioError catch(e){
      print("error");
      print(e.response);
      print(e.message);
      setState(() {
        callingCreateJobApi = false;
      });
    }
    //api call
  }



  Widget createNewPost() {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Column(
      children: [
        Container(
            padding:
                const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xffF3F5F7),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create New Job",
                  style: GoogleFonts.poppins(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    getInputWidget(
                        "Job Title",
                        TextInputType.text,
                        (val) => {
                              setState(() {
                                jobTitle = val;
                              })
                            },[]),
                    getInputWidget(
                        "Job Description",
                        TextInputType.text,
                        (val) => {
                              setState(() {
                                jobDescription = val;
                              })
                            },[]),
                    getInputWidget(
                        "Location",
                        TextInputType.text,
                        (val) => {
                              setState(() {
                                location = val;
                              })
                            },[]),
                    getInputWidget(
                        "Number of workers",
                        TextInputType.number,
                        (val) => {
                              setState(() {
                                noOfWorkers = int.parse(val);
                              })
                            },[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                    getInputWidget(
                        "Wage per hour",
                        TextInputType.number,
                        (val) => {
                              setState(() {
                                wagePerHour = int.parse(val);
                              })
                            },[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Worker Type",
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                        DropdownButtonExample(
                          list: empTypes,
                          onChange:  (val){
                            workerType = val;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => {pickFromDate()},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, padding: EdgeInsets.all(8)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "From Date \n ${formatter.format(fromDate)}",
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => {pickToDate()},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, padding: EdgeInsets.all(8)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "To Date \n ${formatter.format(toDate)}",
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(!callingCreateJobApi )ElevatedButton(
                      onPressed: () => {validateAndSave()},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, padding: EdgeInsets.all(8)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Save",
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ),
                      ),
                    ),

                    if(callingCreateJobApi) Center(
                      child: CircularProgressIndicator(),
                    ),

                    SizedBox(height: 10,),
                    if (errMsgForm.length != 0)
                      Text(
                        errMsgForm,
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.red),
                      ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget getInputWidget(
      String label, TextInputType kebType, Function onChange, List<TextInputFormatter> inputFormatter) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            style: GoogleFonts.lato(fontSize: 18),
            cursorColor: Colors.black,
            keyboardType: kebType,
            onChanged: (val) => onChange(val),
            inputFormatters: inputFormatter,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
