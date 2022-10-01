import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jobportal/Api/Api.dart';
import 'package:jobportal/pages/CreateAccount.dart';
import 'package:jobportal/pages/EmployerHomePage.dart';
import 'package:jobportal/pages/WorkerHomePage.dart';

class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({Key? key}) : super(key: key);

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  Api _api = Api();
  void redirectthem() async {

      Response res = await _api.get(endpoint: '/users/get');
      // print(res.data['userType']);
      print(res.data);

      try { if (res.data['user']['name'] != null) {
        if (res.data['user']['userType'] == 'Worker') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => (WorkerHomePage())),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => (EmployerHomePage())),
              (route) => false);
        }
      } else if (res.data['user']['name'] == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => (CreateAccount())),
            (route) => false);
      }
    }

  }

  @override
  void initState() {
    redirectthem();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
