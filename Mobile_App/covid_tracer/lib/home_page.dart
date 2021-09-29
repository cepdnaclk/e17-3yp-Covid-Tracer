import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/image1.jpeg'),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 30.0))),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text("Covid Tracer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50.0))),
                  Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Icon(
                        Icons.coronavirus,
                        size: 50.0,
                        color: Colors.red,
                      ))
                ],
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 20.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("For a Well Aware and Safe Sri Lanka",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 20.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("Stay Safe", style: TextStyle(fontSize: 20.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 10.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("Wash Hands and Wear a Mask",
                      style: TextStyle(fontSize: 20.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 10.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("Be Informed and Take Precautions",
                      style: TextStyle(fontSize: 20.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 10.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("Let's Contain the Spread of Covid-19",
                      style: TextStyle(fontSize: 20.0))),
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text("", style: TextStyle(fontSize: 10.0)))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 20, bottom: 10),
                  child: ElevatedButton(
                    child: const Text("LOGIN",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen.shade900,
                        fixedSize: const Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  )),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: "Not Registered ? ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        children: <TextSpan>[
                      TextSpan(
                          text: "Register",
                          style: TextStyle(
                              color: Colors.lightGreen.shade900, fontSize: 20),
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
    );
  }
}
