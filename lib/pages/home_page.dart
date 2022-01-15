import 'package:demo_animation/pages/speech_screen_page.dart';
import 'package:demo_animation/pages/telegram_intro/telegram_intro_page.dart';
import 'package:demo_animation/pages/youtube_shorts/short_videos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width*0.55,
              color: Colors.blue,
              onPressed: (){
              Navigator.pushNamed(context, TelegramIntroPage.id);
            }, child: Text("Telegram Intro", style:  TextStyle(fontSize: 20, color: Colors.white),),),
            SizedBox(height: 20,),
            MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width*0.55,
              color: Colors.blue,
              onPressed: (){
              Navigator.pushNamed(context, ShortVideosPage.id);
            }, child: Text("YouTube Shorts", style:  TextStyle(fontSize: 20, color: Colors.white),),),
            SizedBox(height: 20,),
            MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width*0.55,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, SpeechScreenPage.id);
              }, child: Text("Voice recognition", style:  TextStyle(fontSize: 20, color: Colors.white),),),
          ],
        ),
      ),
    );
  }
}
