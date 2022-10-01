// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class OTPage extends StatefulWidget {
//
//   final String verificationid;
//   const OTPage({Key? key,required this.verificationid}) : super(key: key);
//
//   @override
//   State<OTPage> createState() => _OTPageState();
// }
//
// void signInWithPhone(BuildContext context,String phoneNumber) async {
//   try{
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential)async{
//         await FirebaseAuth.instance.signInWithCredential(credential);
//
//       }, verificationFailed: (e){
//       throw Exception(e.message);
//     },
//       codeSent: ((String verificationId, int? resendToken) async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => OTPage(
//               verificationid:verificationId
//           )),
//         );
//       }),
//       codeAutoRetrievalTimeout: (String verificationId) {},
//
//     );
//   }
//   on FirebaseAuthException catch (e){
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign in with phohne")));
//   }
// }
//
//
// class _OTPageState extends State<OTPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verifying your number'),
//         elevation: 0,
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text('We have sent an SMS with a code.'),
//             SizedBox(
//               width: MediaQuery. of(context). size. width * 0.5,
//               child: TextField(
//                 textAlign: TextAlign.center,
//                 decoration: const InputDecoration(
//                   hintText: '- - - - - -',
//                   hintStyle: TextStyle(
//                     fontSize: 30,
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//                 onChanged: (val) async{
//                   if (val.length == 6) {
//                     await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: val))
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobportal/pages/EmployerHomePage.dart';
import 'package:jobportal/pages/WorkerHomePage.dart';
import 'package:jobportal/pages/login/logout.dart';

import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();


  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify ${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,

              controller: _pinPutController,

              pinAnimationType: PinAnimationType.fade,
              onSubmitted: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => (EmployerHomePage())),
                              (route) => false);
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => EmployerHomePage()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}