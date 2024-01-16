import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/LoginScreen.dart';
import 'package:firebase_miner/Settings.dart';
import 'package:firebase_miner/SignupScreen.dart';
import 'package:firebase_miner/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => ProfilepageState();
}

class ProfilepageState extends State<Profilepage> {
  String useremail=auth.currentUser!.email.toString();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: dark(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: text(),)),
        backgroundColor: background(),
        title: Fun('Profile', 20, FontWeight.normal,a: text()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Setting(),
                ));
              },
              icon: Icon(
                Icons.settings,
                color: seconddark(),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Fun("Email  you loged in with ", 22, FontWeight.bold,a: text() ),
            SizedBox(height: 20,),
            Fun("Email: $useremail", 22,  FontWeight.bold,a: text()),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Fun("Log Out",  25,  FontWeight.bold,a: text() ),
                IconButton(onPressed: () async{
                  if (auth.currentUser != null) {

                    await auth.signOut();
                  } else if (googlesignin.currentUser != null) {

                    await googlesignin.signOut();
                  }
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool(SplashscreenState.KEYLOGIN, false);

                }, icon: Icon(Icons.login_outlined,size: 30,color: text(),)),
              ],
            ),
            SizedBox(height: 20,),
            Center(
              child: TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(),));
              }, child: Fun("Create New Account ",  25,  FontWeight.bold, a: text()
              )),
            ),
            SizedBox(height: 20,),
            Center(
              child: TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
              }, child: Fun("Log in with other Account ",  25,  FontWeight.bold, a: text()
              )),
            ),

          ],
        ),
      ),
    );
  }
}
