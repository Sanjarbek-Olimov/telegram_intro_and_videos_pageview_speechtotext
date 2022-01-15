import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  bool visible = false;
  bool _pressedLike = false;
  bool _onDoubleTap = false;
  bool _pressedDislike = false;

  List likes = ["260k", "120k", "523k", "65k", "5k", "546k"];
  List comment = ["10k", "18k", "12k", "2k", "312", "21k"];
  Map profiles = {
    "Samuel John": "assets/images/Jesus.jpg",
    "Football Pitch": "assets/images/match.jpg",
    "Soccer Club": "assets/images/ball.jpg",
    "Football Club": "assets/images/ball_1.jpg",
    "Chelsea FC": "assets/images/chelsea.jpg",
    "Real Madrid": "assets/images/real.jpg"
  };

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
                  _pressedLike = false;
                  _pressedDislike = false;
                });
                videos.elementAt(_selectedIndex).play();
              },
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return _video(
                    index,
                    likes.elementAt(index),
                    comment.elementAt(index),
                    profiles.keys.elementAt(index),
                    profiles.values.elementAt(index));
              },
            ),
            Center(
              child: AnimatedOpacity(
                opacity: visible ? 0.8 : 0,
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
            _onDoubleTap?Center(child: Lottie.asset("assets/anims/like.json", repeat: false)):const SizedBox.shrink(),
          ],
        ));
  }

  Widget _video(
      int index, String like, String comment, String name, String avatar) {
    return GestureDetector(
      onTap: () {
        setState(() {
          visible = !visible;
        });
        if (!isPause) {
          videos.elementAt(_selectedIndex).pause();
        } else {
          videos.elementAt(_selectedIndex).play();
        }
        Timer(const Duration(milliseconds: 600), () {
          setState(() {
            visible = !visible;
          });
        });
        isPause = !isPause;
      },
      onDoubleTap: (){
        setState(() {
          _onDoubleTap = true;
          _pressedLike = true;
          if(_pressedDislike){
            _pressedDislike = !_pressedDislike;
          }
        });
        Timer.periodic(Duration(milliseconds: 2000), (timer) {
          setState(() {
            _onDoubleTap=false;
          });
        });
      },
      child: Stack(
        children: [
          Center(
            child: videos.elementAt(index).value.isInitialized
                ? AspectRatio(
                    aspectRatio: videos.elementAt(index).value.aspectRatio,
                    child: VideoPlayer(videos.elementAt(index)),
                  )
                : const CircularProgressIndicator(),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.75,
                right: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).size.height * 0.46),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.thumb_up_alt,
                    color: _pressedLike ? Colors.blue.shade400 : Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _pressedLike = !_pressedLike;
                      if (_pressedDislike) {
                        _pressedDislike = !_pressedDislike;
                      }
                    });
                  },
                ),
                Text(
                  like,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.thumb_down_alt,
                    color: _pressedDislike ? Colors.blue.shade400 : Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _pressedDislike = !_pressedDislike;
                      if (_pressedLike) {
                        _pressedLike = !_pressedLike;
                      }
                    });
                  },
                ),
                const Text(
                  "Dislike",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.insert_comment_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {},
                ),
                Text(
                  comment,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.rotationY(pi),
                  child: IconButton(
                    icon: const Icon(
                      Icons.reply,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {},
                  ),
                ),
                const Text(
                  "Share",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white, width: 1)),
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(5),
                  child: Lottie.asset("assets/anims/play.json"),
                )
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width*0.7,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.91,
                  left: MediaQuery.of(context).size.width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    foregroundImage: AssetImage(avatar),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.25,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    height: 30,
                    color: Colors.red.shade600,
                    onPressed: () {},
                    child: const Text(
                      "SUBSCRIBE",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
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
          Container(
              margin: EdgeInsets.only(
                  top: 40, left: MediaQuery.of(context).size.width * 0.88),
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
