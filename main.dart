import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/Splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
  app=await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyAtCdQUUTRJ5loJez5mgW0O-VyJdpWiiuE', appId: '702240813218', messagingSenderId: '', projectId: 'databaseminer-7d68a')
  );
  auth=FirebaseAuth.instanceFor(app: app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: GetStorage().read("appTheme") == true
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
