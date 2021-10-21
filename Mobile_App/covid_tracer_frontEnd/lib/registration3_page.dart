import 'package:flutter/material.dart';

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
                      child: const TextField(
                        decoration: InputDecoration(hintText: "Enter Here"),
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
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Enter Here"),
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
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Enter Here"),
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
                        //to do
                        //Navigator.pushNamed(context, '/register3');
                      },
                    ))
              ])
            ],
          ),
        ));
  }
}
