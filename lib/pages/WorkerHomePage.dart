import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobportal/Model/Job.dart';
import 'package:jobportal/Api/Api.dart';
import 'package:jobportal/Widgets/JobCard.dart';
import 'package:jobportal/pages/login/firstpage.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({Key? key}) : super(key: key);

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  int navIndex = 0;
  List<JobModel> exploreJobs = [];
  List<JobModel> appliedJobs = [];

  bool callingFetchJobsApi = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    fetchPostedJobList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        child: Center(
          child: ListView(
            children: [
              ListTile(
                title: Text("Sign out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
              ),
              ListTile(
                title: Text("Show Profile"),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex,
        onTap: (ind) {
          setState(() {
            navIndex = ind;
          });
          if(ind == 0) {
            fetchPostedJobList();
          } else {
            fetchPostedJobList(filter: "applied");
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: 'My Jobs',
          ),
        ],
      ),
      body: navIndex == 0 ? getExploreWidget() : getMyJobsList(),
    );
  }

  Api _api = new Api();

  void fetchPostedJobList({String? searchTerm, String? filter}) async {
    print("calling fetch job");
    setState(() {
      callingFetchJobsApi = true;
    });
    try {
      Response res = await _api.get(endpoint: "/jobs/worker/list", body: {
        "filter": filter,
        "searchTerm": searchTerm,
      });
      print(filter);
      print(res.data["jobs"]);
      List<dynamic> response = res.data["jobs"];

      print(response);
      List<JobModel> tempJobs = [];
      response.forEach((job) {
        JobModel tempjob = JobModel(
            title: job["jobTitle"],
            description: job["description"],
            location: job["location"],
            noOfWorkers: job["totalWorkersRequired"],
            wagePerHour: job["payPerHour"],
            fromDate: DateTime.parse(job["startsOn"]),
            toDate: DateTime.parse(job["endsOn"]),
            workerType: job["workerTagRequired"],
            jobId: job["jobId"],
            appliedWorkersCount: job["appliedWorkersCount"],
        );

        tempjob.applied = job["applied"];
        tempJobs.add(tempjob);
      });

      setState(() {
        if(filter == null || filter == "search") {
          exploreJobs = tempJobs;
        } else {
          appliedJobs = tempJobs;
        }
        callingFetchJobsApi = false;
      });

    } on DioError catch (e) {
      print(e.response);
      setState(() {
        callingFetchJobsApi = false;
      });
    }
  }

  Widget getExploreWidget() {
    return Column(
      children: [
        //upper portion of page containing user info and search box
        Container(
            padding:
                const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
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
                        GestureDetector(
                          child: const CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Sushant Mishra",
                            style: GoogleFonts.poppins(fontSize: 20))
                      ],
                    ),
                    const Icon(
                      Icons.notifications,
                      size: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Find a Job",
                  style: GoogleFonts.poppins(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: TextField(
                            onChanged: (val){
                              fetchPostedJobList(filter: "search", searchTerm: val);
                            },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.lato(fontSize: 20),
                      )),
                    ],
                  ),
                )
              ],
            )),

        //job list rendering
        Expanded(
          child: callingFetchJobsApi
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, ind) {
                    return JobCard(
                      job: exploreJobs[ind],
                    );
                  },
                  itemCount: exploreJobs.length,
                ),
        )
      ],
    );
  }

  Widget getMyJobsList() {
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
                  "Applied Jobs",
                  style: GoogleFonts.poppins(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Expanded(
          child: callingFetchJobsApi ? Center(child: CircularProgressIndicator(),) : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, ind) {
              return JobCard(
                job: appliedJobs[ind],
              );
            },
            itemCount: appliedJobs.length,
          ),
        )
      ],
    );
  }
}
