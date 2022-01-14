import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortVideosPage extends StatefulWidget {
  static const String id = "ShortVideos_page";

  const ShortVideosPage({Key? key}) : super(key: key);

  @override
  _ShortVideosPageState createState() => _ShortVideosPageState();
}

class _ShortVideosPageState extends State<ShortVideosPage> {
  int _selectedIndex = 0;
  bool isPause = false;
  bool _visible = false;

  List videos = [
    VideoPlayerController.asset("assets/videos/1.mp4")
      ..initialize()
      ..setLooping(true),
    VideoPlayerController.asset("assets/videos/2.mp4")
      ..initialize()
      ..setLooping(true),
    VideoPlayerController.asset("assets/videos/3.mp4")
      ..initialize()
      ..setLooping(true),
    VideoPlayerController.asset("assets/videos/4.mp4")
      ..initialize()
      ..setLooping(true),
    VideoPlayerController.asset("assets/videos/5.mp4")
      ..initialize()
      ..setLooping(true),
    VideoPlayerController.asset("assets/videos/6.mp4")
      ..initialize()
      ..setLooping(true),
  ];

  @override
  void initState() {
    super.initState();
    videos.elementAt(0)
      ..play()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (var video in videos) {
      video.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                if (_selectedIndex != index) {
                  videos.elementAt(_selectedIndex).seekTo(Duration.zero);
                }
                setState(() {
                  _selectedIndex = index;
                  if (isPause) {
                    isPause = !isPause;
                  }
                });
                videos.elementAt(_selectedIndex).play();
              },
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return _video(index);
              },
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _visible ? 0.8 : 0,
                duration: const Duration(milliseconds: 600),
                child: isPause
                    ? Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(0, 0, 0, 0.8)),
                        child: const Icon(
                          Icons.pause,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(0, 0, 0, 0.8)),
                        child: const Icon(Icons.play_arrow,
                            size: 50, color: Colors.white),
                      ),
              ),
            ),
            GestureDetector(
                onTap: () {
              setState(() {
                _visible = !_visible;
              });
              if (!isPause) {
                videos.elementAt(_selectedIndex).pause();
              } else {
                videos.elementAt(_selectedIndex).play();
              }
              Timer(const Duration(milliseconds: 600), () {
                setState(() {
                  _visible = !_visible;
                });
              });
              isPause = !isPause;
            },
            ),
            Container(
                margin: const EdgeInsets.only(top: 40, left: 10),
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                    ))),
          ],
        ));
  }

  Widget _video(int index) {
    return Stack(
      children: [
        Center(
          child: videos.elementAt(index).value.isInitialized
              ? AspectRatio(
                  aspectRatio: videos.elementAt(index).value.aspectRatio,
                  child: VideoPlayer(videos.elementAt(index)),
                )
              : const CircularProgressIndicator(),
        ),
      ],
    );
  }
}
