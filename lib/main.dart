import 'dart:io';
import 'package:demo_animation/pages/home_page.dart';
import 'package:demo_animation/pages/telegram_intro/telegram_intro_page.dart';
import 'package:demo_animation/pages/youtube_shorts/short_videos.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());

  await getDeviceDetails().then((value) => print(value));

}

Future<Map> getDeviceDetails() async {
  String deviceName;
  String identifier;

  Map info = {};

  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      identifier = build.androidId;
      info.addAll({"deviceName":deviceName, "identifier":identifier, "isRealDevice":build.isPhysicalDevice});//UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      identifier = data.identifierForVendor;
      info.addAll({"deviceName":deviceName, "identifier":identifier, "isRealDevice":data.isPhysicalDevice});//UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

//if (!mounted) return;
  return info;
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        TelegramIntroPage.id: (context) => const TelegramIntroPage(),
        ShortVideosPage.id: (context)=> const ShortVideosPage(),
      },
    );
  }
}

