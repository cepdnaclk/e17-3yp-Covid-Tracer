import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 15),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username/NIC",
                      hintText: "Enter Username or NIC"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 15, bottom: 25),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
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
                          login(context);
                          //Navigator.pushNamed(context, '/main_menu');
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

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Future<void> login(BuildContext context) async {
  if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    var response = await http.post(
        Uri.parse("http://10.0.2.2:8000/accounts/login"),
        body: ({
          "username": nameController.text,
          "password": passwordController.text
        }));
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/main_menu');
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Alert Message"),
          content: const Text("Invalid Credentials"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("okay"),
            ),
          ],
        ),
      );
    }
  } else {
    Navigator.pushNamed(context, '/main_menu');
    /*
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert Message!"),
        content: const Text("Blank Fields are not allowed!!!"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("okay"),
          ),
        ],
      ),
    );
    */
  }
}
