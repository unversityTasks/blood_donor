import 'package:blood_donor/config/routes/app_routes.dart';
import 'package:blood_donor/core/components/custom_dialogs.dart';
import 'package:blood_donor/core/utils/constants.dart';
import 'package:blood_donor/core/utils/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey =  GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool validateSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateSubmit() async {
    if (validateSave()) {
      try {
        CustomDialogs.progressDialog(context: context, message: 'Signing In');
       
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
            context, Routes.home);
      } catch (e) {
        print('Errr : $e');
        showDialog(
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('User Sign-In Failed !'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      formkey.currentState!.reset();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      systemNavigationBarColor: Colors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor:const  Color.fromARGB(1000, 221, 46, 68),
      body: SingleChildScrollView(
              child: Column(
          children: [
            SizedBox(
                          height:Constants.getHeight(context)/2.5,

              child: const Center(
                  child:  Text("Blood Donor",
                  style: TextStyle(
                    fontFamily: "SouthernAire",
                    fontSize: 80.0,
                    color: Colors.white,
                  ),),
                ),
            ),
        
            ClipRRect(
              borderRadius:const  BorderRadius.only(
                  topLeft:  Radius.circular(40.0),
                  topRight:  Radius.circular(40.0)),
              child: Container(
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/2.5,
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:  Form(
                          key: formkey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Email ID',
                                    icon: Icon(
                                      IconBroken.Message,
                                      color: Color.fromARGB(1000, 221, 46, 68),
                                    ),
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? "Email ID field can't be empty"
                                      : null,
                                  onSaved: (value) => _email = value,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  decoration:const InputDecoration(
                                    hintText: 'Password',
                                    icon: Icon(
                                      IconBroken.Lock,
                                      color: Color.fromARGB(1000, 221, 46, 68),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (value) => value!.isEmpty
                                      ? "Password field can't be empty"
                                      : null,
                                  onSaved: (value) => _password = value,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              RaisedButton(
                                onPressed: validateSubmit,
                                textColor: Colors.white,
                                padding:const EdgeInsets.only(left: 5.0, right: 5.0),
                                color:const Color.fromARGB(1000, 221, 46, 68),
                                child: Text("LOGIN"),
                                shape:  RoundedRectangleBorder(
                                    borderRadius:  BorderRadius.circular(30.0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("New User? "),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              Routes.register);
                                        },
                                        child:const Text(
                                          "Click here",
                                          style: TextStyle(
                                            color: Color.fromARGB(1000, 221, 46, 68),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
