

import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/Profilepage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => SettingsState();
}

class SettingsState extends State<Setting> {
  @override
  void initState() {
    super.initState();
  }
  void initializeTheme()async{
    bool? storedThemeMode =GetStorage().read("appTheme");
    if(storedThemeMode !=null){
      isDarkMode.value=storedThemeMode;
      updateThemeMode(isDarkMode.value);
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: text(),)),
        title: Fun('Settings', 20, FontWeight.normal,a: text()),
        centerTitle: true,
        backgroundColor: background(),
      ),
      backgroundColor: dark(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                isDarkMode.value=!isDarkMode.value;
                print(isDarkMode.value);
                updateThemeMode(isDarkMode.value);
              },
              child: Container(
                height: 60,
                width: double.infinity,
                child: Center(
                    child: Fun('ThemeMode', 25, FontWeight.bold,a: dark())),
                decoration: BoxDecoration(
                  color: seconddark(),
                  border: Border.all(color: dark()),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profilepage(),));
              },
              child: Container(
                height: 60,
                width: double.infinity,
                child: Center(
                    child: Fun('Profile', 25, FontWeight.bold,a: dark())),
                decoration: BoxDecoration(
                  color: seconddark(),
                  border: Border.all(color: dark()),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
