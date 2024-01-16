import 'dart:async';

import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/Homescreen.dart';
import 'package:firebase_miner/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  static const String KEYLOGIN = 'login';
  @override
  void initState() {
    super.initState();
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 230),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: seconddark(),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
          ),

          Container(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'Assates/Images/Logo.png',
                    height: 150,
                    width: 150,
                    color: text(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Fun('Chat App', 50, FontWeight.bold,a: text()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 220,),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: dark(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void fun() async {
    var Prefs = await SharedPreferences.getInstance();
    var isloggedIn = Prefs.getBool(KEYLOGIN);

    Timer(Duration(seconds: 3), () {
      if (isloggedIn != null) {
        if (isloggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homescreen()),
          );
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }
}
