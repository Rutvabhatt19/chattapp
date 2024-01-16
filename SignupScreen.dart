import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/Homescreen.dart';
import 'package:firebase_miner/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_contriller = TextEditingController();
  TextEditingController username_contriller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Fun('Creat New Account', 25, FontWeight.normal,a: text()),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: fun(username_contriller, 'Username'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: fun(email_controller, 'E-mail'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: fun(password_contriller, 'Password',a: true),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    guest=false;
                    await auth.createUserWithEmailAndPassword(
                        email: email_controller.text,
                        password: password_contriller.text);
                    Map<String,dynamic> users={
                      'Email':email_controller.text,
                      'Name':username_contriller.text,
                      'Profilepic':null,
                    };
                    await db.collection('USERS').add(users);
                   await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homescreen()));
                  },
                  child: Text('Sign up')),
              SizedBox(
                height: 20,
              ),
              Fun('Or', 30, FontWeight.bold,a: text()),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    guest=false;
                    await googlesignin.signIn();
                    Map<String,dynamic> users={
                      'Email': googlesignin.currentUser!.email,
                      'Name':googlesignin.currentUser!.displayName,
                      'Profilepic':googlesignin.currentUser!.photoUrl,
                    };
                    await db.collection('USERS').add(users);
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homescreen()));
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Image.asset(
                          'Assates/Images/googal.png',
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Fun('Sign in with Googal', 25, FontWeight.bold,a: text()),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: dark()),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await auth.signInAnonymously();
                    guest=true;
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homescreen()));
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                        child: Fun('Sign in as Guest', 25, FontWeight.bold,a: text())),
                    decoration: BoxDecoration(
                      border: Border.all(color: dark()),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
