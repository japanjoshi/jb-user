import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class HomeKriya extends StatefulWidget {
  const HomeKriya({super.key});

  @override
  State<HomeKriya> createState() => _HomeKriyaState();
}

class _HomeKriyaState extends State<HomeKriya> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = true;
  Timer? _timer;
  int _time = 0; // Time in seconds

  @override
  void initState() {
    super.initState();

    _startAudioAndTimer();
  }

  void _startAudioAndTimer() async {
    await _audioPlayer.setAsset('assets/musics/chill0.mp3');
    _audioPlayer.play();
    _startTimer();
    setState(() => _isPlaying = true);
  }

  void _pauseOrResumeAudio() {
    if (_isPlaying) {
      _audioPlayer.pause();
      _timer?.cancel();
    } else {
      _audioPlayer.play();
      _startTimer();
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  void _stopAndExit() {
    _audioPlayer.stop();
    _timer?.cancel();
    _incrementKriyaCountIfNewDay();
    Navigator.pop(
        context); // Assuming this navigates back to 'My Progress' page
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _time++;
      });
    });
  }

  void _incrementKriyaCountIfNewDay() {
    var box = Hive.box('home_kriya_count');
    var datebox = Hive.box('lastKriyaDate');
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String lastKriyaDate = datebox.get('lastKriyaDate', defaultValue: '');

    if (lastKriyaDate != currentDate) {
      int currentCount = box.get('home_kriya_count', defaultValue: 0);
      box.put(0, currentCount + 1);
      datebox.put('lastKriyaDate', currentDate);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              HexColor('FF5A5A'),
              HexColor('FF8D1F'),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 90,
              title: Text(
                'Home Kriya',
                style: GoogleFonts.raleway(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 54.0, top: 150),
                  child: Center(
                    child: Text(
                      _formatTime(_time),
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 220,
                  height: 58,
                  decoration: BoxDecoration(
                    color: HexColor('B53D00'),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: _pauseOrResumeAudio,
                      child: Center(
                        child: Text(
                          _isPlaying ? 'Pause' : 'Resume',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 220,
                  height: 58,
                  decoration: BoxDecoration(
                    color: HexColor('B53D00'),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: InkWell(
                    onTap: _stopAndExit,
                    child: Center(
                      child: Text(
                        'Finish Early',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Image.asset('assets/svg/Mask Group 1.png', fit: BoxFit.cover),
      ],
    );
  }
}
