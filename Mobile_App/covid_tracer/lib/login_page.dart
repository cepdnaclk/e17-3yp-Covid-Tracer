import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text("LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50.0))),
              const Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username/NIC",
                      hintText: "Enter Username or NIC"),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 25),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                ),
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: "Forgot Your Password ?",
                        style: TextStyle(
                            color: Colors.lightGreen.shade900, fontSize: 20),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Navigator.pushNamed(context, '/second');
                          })),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 70, bottom: 10),
                      child: ElevatedButton(
                        child: const Text("LOGIN",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen.shade900,
                            fixedSize: const Size(300, 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        onPressed: () {
                          //to do
                          Navigator.pushNamed(context, '/main_menu');
                        },
                      )),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Not Registered ? ",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            children: <TextSpan>[
                          TextSpan(
                              text: "Register",
                              style: TextStyle(
                                  color: Colors.lightGreen.shade900,
                                  fontSize: 20),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/register1');
                                })
                        ])),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
