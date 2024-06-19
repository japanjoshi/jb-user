import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jb_user_app/screens/home_screen.dart';

import '../../tab_bar.dart';

class BasicDetailsPage2 extends StatefulWidget {
  final Map<String, String>? userData;
  const BasicDetailsPage2({super.key, this.userData});

  @override
  State<BasicDetailsPage2> createState() => _BasicDetailsPage2State();
}

class _BasicDetailsPage2State extends State<BasicDetailsPage2> {
  String? occupation;
  List<String> skills = [];
  List<String> contributions = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: HexColor('FFEFE0'),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: HexColor('FFEFE0').withOpacity(0.9),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Tell us a little more about you',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('My Occupation*',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            choiceChip('Job', 'Job'),
                            choiceChip('Business', 'Business'),
                            choiceChip('Study', 'Study'),
                          ],
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'A little about your occupation',
                        ),
                        onChanged: (value) {
                          setState(() {
                            occupation = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Tell us about your skills*',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 10.0,
                        children: [
                          choiceChip('Creative Art', 'Creative Art'),
                          choiceChip('Management', 'Management'),
                          choiceChip('Marketing', 'Marketing'),
                          choiceChip('Social Media', 'Social Media'),
                          choiceChip('Designing', 'Designing'),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter all your skills here',
                        ),
                        onChanged: (value) {
                          setState(() {
                            skills.add(value);
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                          'If need arises, In what areas would you like to contribute?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 10.0,
                        children: [
                          choiceChip('Donate money', 'Donate money'),
                          choiceChip('Volunteering at courses',
                              'Volunteering at courses'),
                          choiceChip('Blood donation', 'Blood donation'),
                          choiceChip('Seva events', 'Seva events'),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Any other service you\'d like to offer?',
                        ),
                        onChanged: (value) {
                          setState(() {
                            contributions.add(value);
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabBarPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 219,
                            height: 49,
                            decoration: BoxDecoration(
                              color: HexColor('EF6C00'),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget choiceChip(String label, String value) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      label: Container(
        width: 111,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ),
      selected: skills.contains(value),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            skills.add(value);
          } else {
            skills.removeWhere((String name) {
              return name == value;
            });
          }
        });
      },
    );
  }
}
