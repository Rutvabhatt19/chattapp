import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

void updateThemeMode(bool darkMode) {
  Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
}
String collectionName='USERS';
RxBool isDarkMode = false.obs;
dynamic user=FirebaseAuth.instance.currentUser;
Color background() {
  return isDarkMode.value ? Color(0xff2D2C54) : Color(0xff1A737D);
}

Color text() {
  return isDarkMode.value ? Color(0xffAAA9B8) : Color(0xffD0E7E2);
}

Color seconddark() {
  return isDarkMode.value ? Color(0xffEAEAEB) : Color(0xffE0E0E1);
}

Color dark() {
  return isDarkMode.value ? Color(0xff464687) : Color(0xffA7D4E4);
}

Text Fun(String atext, double size, FontWeight b,{Color a=Colors.blue}) {
  return Text(
    atext,
    style: GoogleFonts.salsa(
        textStyle: TextStyle(
          color: a,
          fontWeight: b,
          fontSize: size,
    )),
  );
}
bool guest=false;
late FirebaseAuth auth;
late FirebaseApp app;
GoogleSignIn googlesignin = GoogleSignIn();
final db = FirebaseFirestore.instance;

TextField fun(TextEditingController controller, String hint_text,{bool a=false}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: dark()),
      ),
      hoverColor: text(),
      hintText: hint_text,
      hintStyle: GoogleFonts.salsa(
          textStyle: TextStyle(
            color: text(),
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )),
    ),
    obscureText: a,
  );
}