import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'registration1_page.dart';
import 'registration2_page.dart';
import 'registration3_page.dart';
import 'main_menu.dart';
import 'settings.dart';
import 'trace_location.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Route Navigation',
    theme: ThemeData(
        // This is the theme of your application.
        //primarySwatch: Colors.lightGreen,
        ),
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const HomeScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/login': (context) => const LoginScreen(),
      '/register1': (context) => const RegisterScreen1(),
      '/register2': (context) => const RegisterScreen2(),
      '/register3': (context) => const RegisterScreen3(),
      '/main_menu': (context) => const MenuScreen(),
      '/settings': (context) => const SettingsScreen(),
      '/trace_location': (context) => const TraceLocationScreen(),
    },
  ));
}
