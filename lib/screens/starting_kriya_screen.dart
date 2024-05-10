import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class StartingKiryaScreen extends StatefulWidget {
  const StartingKiryaScreen({super.key});

  @override
  State<StartingKiryaScreen> createState() => _StartingKiryaScreenState();
}

class _StartingKiryaScreenState extends State<StartingKiryaScreen> {
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
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 22.0, top: 150, left: 10, right: 10),
                  child: Center(
                    child: Text(
                      'Sit in a quite and comfortable place.\n Follow the instructions given in the audio.',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
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
                    child: Text(
                      'Pause',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 19,
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
              ],
            ),
          ),
        ),
        Image.asset('assets/svg/Mask Group 1.png', fit: BoxFit.cover),
      ],
    );
  }
}
