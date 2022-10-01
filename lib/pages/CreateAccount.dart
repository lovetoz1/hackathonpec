import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jobportal/Widgets/CustomDropdown.dart';
import 'package:jobportal/pages/EmployerHomePage.dart';
import 'package:jobportal/pages/WorkerHomePage.dart';
import 'package:page_transition/page_transition.dart';

import '../Api/Api.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: createNewAccount());
  }


  String UserName = "";
  String UserType = "worker";
  String WorkerType = "";
  String errMsgForm = "";


  List<String> empTypes = ["Labourer", "Electrician", "Carpenter"];

  bool callingApi = false;

  
  Api _api = Api();

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

      if(UserType == "Worker"){
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


  Widget createNewAccount() {
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
                  "Create New Account",
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

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputWidget(
                        "User Name",
                        TextInputType.text,
                            (val) => {
                          setState(() {
                            UserName = val;
                          })
                        },[]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User Type", style:  GoogleFonts.poppins(fontSize: 15),),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              UserType = "worker";
                            });
                          },
                          child: Container(
                            height:50,
                            width: 70,
                            decoration:BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: UserType == "worker" ? Colors.blue : Colors.transparent,
                            ),
                            child: Center(
                              child: Text("Worker"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              UserType = "employer";
                            });
                          },
                          child: Container(
                            height:50,
                            width: 70,
                            decoration:BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: UserType == "employer" ? Colors.blue : Colors.transparent,
                            ),
                            child: Center(
                              child: Text("Employer"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    if(UserType == "worker")Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Worker Type",
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                        DropdownButtonExample(
                          list: empTypes,
                          onChange:  (val){
                            WorkerType = val;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(!callingApi)ElevatedButton(
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
                    if(callingApi) const Center(
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
