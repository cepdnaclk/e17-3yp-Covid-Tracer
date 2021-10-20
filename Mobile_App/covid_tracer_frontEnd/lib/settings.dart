import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Covid Tracer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50.0))),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.coronavirus,
                    size: 50.0,
                    color: Colors.red,
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
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
                        Icons.account_box,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("My Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
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
                        Icons.menu,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("Services",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
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
                        Icons.notifications,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("Notifications",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
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
                        Icons.info,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("About this App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
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
                        Icons.logout,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text("Log Out",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  child: IconButton(
                    onPressed: () {},
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
