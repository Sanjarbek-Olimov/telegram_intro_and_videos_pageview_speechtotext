import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'first_lottie.dart';

class TelegramIntroPage extends StatefulWidget {
  static const String id = "TelegramIntro_page";

  const TelegramIntroPage({Key? key}) : super(key: key);

  @override
  _TelegramIntroPageState createState() => _TelegramIntroPageState();
}

class _TelegramIntroPageState extends State<TelegramIntroPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  List titles = [
    "Telegram",
    "Fast",
    "Free",
    "Powerful",
    "Secure",
    "Cloud-Based"
  ];

  List subtitle = [
    RichText(
      text: const TextSpan(text: "The world's ", style: TextStyle(color: Colors.black, fontSize: 16),children: [
        TextSpan(
            text: "fastest ", style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: "messaging app.\nIt is "),
        TextSpan(text: "free ", style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: "and "),
        TextSpan(
            text: "secure.", style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    RichText(
      text: const TextSpan(
          text: "Telegram ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
                text: "delivers messages\nfaster than any other application.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ]),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    RichText(
      text: const TextSpan(
          text: "Telegram ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
                text: "is free forever. No ads.\nNo subscription fees.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ]),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    RichText(
      text: const TextSpan(
          text: "Telegram ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
                text: "has no limits on\nthe size of your media and chats.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ]),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    RichText(
      text: const TextSpan(
          text: "Telegram ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
                text: "keeps your messages\nsafe from hacker attacks.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ]),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    RichText(
      text: const TextSpan(
          text: "Telegram ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
                text: "lets you access your\nmessages from multiple devices.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ]),
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
  ];

  List anims = [
    FirtsLottie(lottie: "assets/anims/1_telegram.json"),
    FirtsLottie(lottie: "assets/anims/fast.json"),
    FirtsLottie(lottie: "assets/anims/gift.json"),
    FirtsLottie(lottie: "assets/anims/infinity.json"),
    FirtsLottie(lottie: "assets/anims/lock.json"),
    FirtsLottie(lottie: "assets/anims/cloud.json"),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticIn));
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SlideTransition(
        position: _animation,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Center(child: anims[_selectedIndex]),
            ),
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: List.generate(
                  titles.length,
                      (index) =>
                      _pages(title: titles[index], subtitle: subtitle[index])),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.14),
              child: SmoothPageIndicator(
                controller: _pageController, count: anims.length,
                effect: WormEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    dotColor: Colors.grey.shade300,
                    activeDotColor: Colors.grey), // your preferred effect
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.04),
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Start Messaging",
                    style: TextStyle(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pages({required String title, required RichText subtitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )),
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              alignment: Alignment.topCenter,
              child: subtitle
            ))
      ],
    );
  }
}
