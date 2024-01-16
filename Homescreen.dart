import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/ChatPage.dart';
import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/LoginScreen.dart';
import 'package:firebase_miner/Settings.dart';
import 'package:firebase_miner/SignupScreen.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: background(),
        title: Fun('Homescreen', 20, FontWeight.normal,a: text()),
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
      body:guest? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Fun("You don't have an account ", 20,FontWeight.normal, a:text())),
          Center(
            child: InkWell(onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(),));
            },child: Fun("Create New Account ", 20,FontWeight.normal, a:text())),
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
                child: Fun("Log in with your an account ", 20,FontWeight.normal, a:text())),
          ),
        ],
      ): StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(collectionName).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            };
            var users = snapshot.data!.docs;
            List<Widget> userlist = [];
            for (var user in users) {
              var userdata = user.data() as Map<String, dynamic>;
              if (auth.currentUser!.email != userdata['Email']) {
                userlist.add(
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chatpage(username: userdata['Name'].toString(), uid: user.id, email: userdata['Email'].toString()),));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Fun(userdata['Name'].toString(), 20, FontWeight.normal,a: text()),
                          Fun(userdata['Email'].toString(), 20, FontWeight.normal,a: text()),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return ListView(
              children: userlist,
            );
          }),
    );
  }
}
