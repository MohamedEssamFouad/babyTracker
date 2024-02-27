import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Views/Home.dart';
import 'Views/SIXTHScreen.dart';
import 'controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  tz.initializeTimeZones();

  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // Use the name of your app icon file

  var initializationSettings = InitializationSettings(

      android: initializationSettingsAndroid, );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;
  Get.put(NavigationController());


  runApp(MyApp(isFirstLaunch: !hasSeenIntro));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  MyApp({Key? key, required this.isFirstLaunch}) : super(key: key); // updated constructor syntax

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstLaunch ? INTRO() : SIXTHScreen(),
    );
  }
}
