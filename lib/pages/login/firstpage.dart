// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jobportal/pages/HomePage.dart';
// import 'package:jobportal/pages/login/loginrepo/authrepo.dart';
// import 'package:jobportal/pages/login/otp.dart';
//
// class FirstPage extends StatefulWidget {
//   const FirstPage({Key? key}) : super(key: key);
//
//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }
//
// class _FirstPageState extends State<FirstPage> {
//   final myController = TextEditingController();
//   void _printLatestValue() {
//     print('Second text field: ${myController.text}');
//     fixedLengthList.clear();
//     String a = myController.text;
//     for (int i = 0; i < a.length; i++) {
//       fixedLengthList.add(a[i]);
//     }
//   }
//
//   final fixedLengthList = List<String>.filled(10, '');
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     myController.dispose();
//     super.dispose();
//   }
//
//
//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
//         decoration: BoxDecoration(color: Colors.blue),
//         child: Center(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: new BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 15, right: 15, top: 5),
//                       child: TextFormField(
//                         maxLength: 10,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           prefixText: '+91',
//                           border: InputBorder.none,
//                           labelText: 'Phone Number',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 GestureDetector(
//                   onTap: ,
//                   child: Container(
//                     child: Text("press here"),
//                   ),
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
// import 'package:jobportal/pages/login/otp.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Auth'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(children: [
//             Container(
//               margin: EdgeInsets.only(top: 60),
//               child: Center(
//                 child: Text(
//                   'Phone Authentication',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 40, right: 10, left: 10),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Phone Number',
//                   prefix: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: Text('+1'),
//                   ),
//                 ),
//                 maxLength: 10,
//                 keyboardType: TextInputType.number,
//                 controller: _controller,
//               ),
//             )
//           ]),
//           Container(
//             margin: EdgeInsets.all(10),
//             width: double.infinity,
//             child: ElevatedButton(
//               // color: Colors.blue,
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => OTPScreen(_controller.text)));
//               },
//               child: Text(
//                 'Next',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }








import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jobportal/pages/login/otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();
  bool _isLoading = false;
 String intcode="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://ouch-cdn2.icons8.com/n9XQxiCMz0_zpnfg9oldMbtSsG7X6NwZi_kLccbLOKw/rs:fit:392:392/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNDMv/MGE2N2YwYzMtMjQw/NC00MTFjLWE2MTct/ZDk5MTNiY2IzNGY0/LnN2Zw.png', fit: BoxFit.cover, width: 280, ),
                SizedBox(height: 50,),
             Text('REGISTER',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey.shade900),),
             
                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                    child: Text('Enter your phone number to continu, we will send you OTP to verifiy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),),
                  ),
                SizedBox(height: 30,),
                 Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(0.13)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffeeeeee),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                           intcode=number.phoneNumber!;
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          textFieldController: controller,
                          formatInput: false,
                          maxLength: 10,
                          keyboardType:
                          TextInputType.numberWithOptions(signed: true, decimal: true),
                          cursorColor: Colors.black,
                          inputDecoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                          ),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
                        Positioned(
                          left: 90,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            height: 40,
                            width: 1,
                            color: Colors.black.withOpacity(0.13),
                          ),
                        )
                      ],
                    ),
                  ),
                
                SizedBox(height: 100,),
                MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      print(intcode);
                      setState(() {
                        _isLoading = true;
                      });


                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          _isLoading = false;
                        });
                        print(intcode);
                        intcode=intcode.toString();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(intcode)));
                      });
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: _isLoading  ? Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ) :
                    Text("Request OTP", style: TextStyle(color: Colors.white),),
                  ),
                SizedBox(height: 20,),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Press On above key', style: TextStyle(color: Colors.grey.shade700),),
                      SizedBox(width: 5,),

                    ],
                  ),
              ],
            ),
          ),
        )
    );
  }
}