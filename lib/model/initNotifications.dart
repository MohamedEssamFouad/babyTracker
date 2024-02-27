import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../Views/SIXTHScreen.dart';

class InitNotifications {
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,


    );
  }
  static Future<void> scheduleNotification(FlutterLocalNotificationsPlugin notificationsPlugin, String title, String body, DateTime scheduledTime) async {
    tz.initializeTimeZones();


     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
sound: RawResourceAndroidNotificationSound('rrr'),


      fullScreenIntent: true,
    );
     NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails);
    await notificationsPlugin.zonedSchedule(
      0,
      title,
      payload:"dd",
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
          .absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  static onTap(NotificationResponse notificationResponse){
  log(notificationResponse.id!.toString());
  log(notificationResponse.payload!.toString());
  print(log);
  Get.to(()=>SIXTHScreen());


  }
  }


