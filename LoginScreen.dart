import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/Homescreen.dart';
import 'package:firebase_miner/SignupScreen.dart';
import 'package:firebase_miner/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
              Center(
                child: Image.asset(
                  'Assates/Images/Logo.png',
                  height: 90,
                  width: 90,
                  color: text(),
                ),
              ),
              SizedBox(
                height: 60,
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
                    await auth.signInWithEmailAndPassword(
                        email: email_controller.text,
                        password: password_contriller.text);
                    user=auth.currentUser;
                    ischecktoNextPage(email_controller.text,username_contriller.text);

                  },
                  child: Text('Sign in')),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: 10,
                  ),
                  Fun("Don't have an account ?", 10, FontWeight.bold,a: text()),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(),));
                      },
                      child: Fun(" Create an account", 10, FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> isEmailAlreadyInCollection(String email,)async{
    QuerySnapshot<Map<String,dynamic>> querySnapshot=await FirebaseFirestore.instance.collection(collectionName).
    where("Email",isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }
  void ischecktoNextPage(String email,String name) async{
    bool isEmailExists =await isEmailAlreadyInCollection(email);


    if(isEmailExists){
      final prefs=await SharedPreferences.getInstance();
      prefs.setBool(SplashscreenState.KEYLOGIN, true);
      await prefs.setString("MainUser_name", name);
      await prefs.setString("MainUser_email", email);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homescreen(),));
    }

    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You Don't have Account With this Email right correct email."),
            duration: Duration(seconds: 3),
          ));
    }
  }

}
