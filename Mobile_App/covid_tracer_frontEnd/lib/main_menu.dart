import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreen createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 10),
                  child: Text("Covid Tracer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50.0))),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 40, bottom: 10),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.all(15),
            color: Colors.lightGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration:
                        BoxDecoration(color: Colors.lightGreen.shade900),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Icon(
                        Icons.qr_code,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
                    child: Text("Check-In to a Venue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/settings');
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            color: Colors.lightGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration:
                        BoxDecoration(color: Colors.lightGreen.shade900),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Icon(
                        Icons.location_on,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("Check a location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/settings');
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            color: Colors.lightGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration:
                        BoxDecoration(color: Colors.lightGreen.shade900),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Icon(
                        Icons.map,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("Trace my location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/trace_location');
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            color: Colors.lightGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration:
                        BoxDecoration(color: Colors.lightGreen.shade900),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Icon(
                        Icons.thermostat,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("My temperatures",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/settings');
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            color: Colors.lightGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration:
                        BoxDecoration(color: Colors.lightGreen.shade900),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Icon(
                        Icons.article,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("Health News",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/settings');
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
