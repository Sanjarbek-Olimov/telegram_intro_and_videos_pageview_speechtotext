import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreenPage extends StatefulWidget {
  static const String id = "speech_screen_page";

  const SpeechScreenPage({Key? key}) : super(key: key);

  @override
  _SpeechScreenPageState createState() => _SpeechScreenPageState();
}

class _SpeechScreenPageState extends State<SpeechScreenPage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _words = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }


  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(result) {
    setState(() {
      _words = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice Recognition"),
        centerTitle: true,
      ),
      floatingActionButton: AvatarGlow(
        animate: _speechToText.isListening ? true : false,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(seconds: 1),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
          child: Icon(_speechToText.isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            _words,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify  ,
          ),
        ),
      ),
    );
  }
}
