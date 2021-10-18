import 'package:flutter/material.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({Key? key}) : super(key: key);

  @override
  _RegisterScreen1 createState() => _RegisterScreen1();
}

class _RegisterScreen1 extends State<RegisterScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
        ),
        body: Column(
          children: [
            const Padding(
                padding:
                    EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 25),
                child: Text("REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 50.0))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.looks_one,
                  size: 50.0,
                  color: Colors.lightGreen,
                ),
                Icon(
                  Icons.looks_two,
                  size: 50.0,
                  color: Colors.lightGreen,
                ),
                Icon(
                  Icons.looks_3,
                  size: 50.0,
                  color: Colors.lightGreen,
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(35),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreen.shade900, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                        "Please verify your identity by scanning the NIC",
                        style: TextStyle(fontSize: 18.0)),
                  ),
                  Text("", style: TextStyle(fontSize: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                        "This step is crucial to ensure the transparency of your details",
                        style: TextStyle(fontSize: 18.0)),
                  ),
                  Text("", style: TextStyle(fontSize: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                        "We highly value your privacy       Your data will be safe with us", //don't remove these extra spaces
                        style: TextStyle(fontSize: 18.0)),
                  ),
                ],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 40, bottom: 10),
                  child: ElevatedButton(
                    child: const Text("Scan Now",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen.shade900,
                        fixedSize: const Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      //to do
                      Navigator.pushNamed(context, '/register2');
                    },
                  ))
            ]),
          ],
        ));
  }
}
