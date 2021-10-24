import 'package:covid_tracer/registration2_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen3 extends StatefulWidget {
  const RegisterScreen3({Key? key}) : super(key: key);

  @override
  _RegisterScreen3 createState() => _RegisterScreen3();
}

class _RegisterScreen3 extends State<RegisterScreen3> {
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
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                  child: Text("REGISTER",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50.0))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.looks_one,
                    size: 50.0,
                    color: Colors.lightGreen.shade900,
                  ),
                  Icon(
                    Icons.looks_two,
                    size: 50.0,
                    color: Colors.lightGreen.shade900,
                  ),
                  const Icon(
                    Icons.looks_3,
                    size: 50.0,
                    color: Colors.lightGreen,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10),
                      child:
                          Text("Username", style: TextStyle(fontSize: 20.0))),
                  Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 15),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.lightGreen, width: 4),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: usernameController,
                        decoration:
                            const InputDecoration(hintText: "Enter Here"),
                      )),
                  const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10),
                      child:
                          Text("Password", style: TextStyle(fontSize: 20.0))),
                  Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 15),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.lightGreen, width: 4),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(hintText: "Enter Here"),
                      )),
                  const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 10),
                      child: Text("Confirm Password",
                          style: TextStyle(fontSize: 20.0))),
                  Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 15),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.lightGreen, width: 4),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: password1Controller,
                        obscureText: true,
                        decoration:
                            const InputDecoration(hintText: "Enter Here"),
                      )),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Container(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    child: ElevatedButton(
                      child: const Text("Finish",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen.shade900,
                          fixedSize: const Size(300, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        register3(context);
                        //Navigator.pushNamed(context, '/main_menu');
                      },
                    ))
              ])
            ],
          ),
        ));
  }
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController password1Controller = TextEditingController();

Future<void> register3(BuildContext context) async {
  if (usernameController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      password1Controller.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      emailController.text.isNotEmpty) {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8000/accounts/register"),
            body: ({
              "contact": phoneController.text,
              "email": emailController.text,
              "username": usernameController.text,
              "password": passwordController.text,
              "password1": password1Controller.text
            }));
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/main_menu');
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Alert Message"),
          content: const Text("Something Went Wrong!!!"),
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
