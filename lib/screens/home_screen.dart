import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jb_user_app/models/seva_model.dart';
import 'package:jb_user_app/screens/ui/course_info.dart/course_info_screen.dart';

import '../models/course_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Course>> fetchCourses() async {
    final FirebaseDatabase database = FirebaseDatabase(
        databaseURL:
            'https://jbadmin-e0498-default-rtdb.asia-southeast1.firebasedatabase.app');
    final DatabaseReference dbRef = database.ref().child('courses');
    List<Course> courses = [];
    try {
      DataSnapshot snapshot = await dbRef.get();

      if (snapshot.exists) {
        // Since the data is a List, we handle it accordingly
        final coursesList = List.from(snapshot.value as List);
        for (var courseData in coursesList) {
          if (courseData is Map<dynamic, dynamic>) {
            // Convert the inner map to the type we expect
            Course course = Course.fromMap(courseData);
            courses.add(course);
          }
        }
      }
      return courses;
    } catch (e) {
      print('Error fetching courses: $e');
      return [];
    }
  }

  Future<List<Seva>> fetchSeva() async {
    final FirebaseDatabase database = FirebaseDatabase(
        databaseURL:
            'https://jbadmin-e0498-default-rtdb.asia-southeast1.firebasedatabase.app');
    final DatabaseReference dbRef = database.ref().child('seva');
    List<Seva> sevas = [];
    try {
      DataSnapshot snapshot = await dbRef.get();

      if (snapshot.exists) {
        // Since the data is a List, we handle it accordingly
        final sevaList = List.from(snapshot.value as List);
        for (var sevaData in sevaList) {
          if (sevaData is Map<dynamic, dynamic>) {
            // Convert the inner map to the type we expect
            Seva seva = Seva.fromMap(sevaData);
            sevas.add(seva);
          }
        }
      }
      return sevas;
    } catch (e) {
      print('Error fetching courses: $e');
      return [];
    }
  }

  final CarouselController _controller = CarouselController();
  int current = 0;

  List currentC = [];

  List<String> videoLink = [
    'https://www.youtube.com/watch?v=UvIuSIIuzEI',
    'https://www.youtube.com/watch?v=mJYmJlc1DmE',
    'https://www.youtube.com/watch?v=ATigF2ga-Ek',
  ];

  List<String> videoId = [
    'UvIuSIIuzEI',
    'mJYmJlc1DmE',
    'ATigF2ga-Ek',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: HexColor('FFEFE0'),
            // gradient: LinearGradient(
            //   colors: [
            //     HexColor('FFA44B').withOpacity(1),
            //     HexColor('FFEFE0'),
            //   ],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, bottom: 15, top: 25),
                    child: Text(
                      'What\'s new?',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  FutureBuilder<List<Course>>(
                    future: fetchCourses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No courses available'));
                      } else {
                        // Data is fetched successfully
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CarouselSlider.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index, realIndex) {
                              final course = snapshot.data![index];
                              // Replace the placeholder widget with your actual widgets
                              return Padding(
                                padding: const EdgeInsets.only(right: 9.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CourseInfoScreen(
                                          course: course,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 377,
                                      height: 190,
                                      child: Image.network(
                                        course.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              padEnds: false,

                              enlargeCenterPage: false,
                              viewportFraction: 0.9,
                              aspectRatio: 2.1,
                              disableCenter: false,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              // autoPlayInterval: Duration(minutes: 1),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: currentC.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey
                                      : Colors.black)
                                  .withOpacity(
                                      current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, bottom: 10, top: 20),
                    child: Text(
                      'Sri Sri says',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 40),
                          child: Text(
                            'Happiness is living in the moment with joy, awareness and compassion;being  free from within…',
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.circle,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, bottom: 10, top: 20),
                    child: Text(
                      'Meditate with Gurudev',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: videoId.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 377,
                          height: 190,
                          child: Image.network(
                            'https://img.youtube.com/vi/${videoId[itemIndex]}/0.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      enlargeCenterPage: false,
                      viewportFraction: 0.9,
                      aspectRatio: 2.1,
                      disableCenter: false,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      // autoPlayInterval: Duration(minutes: 1),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, bottom: 10, top: 20),
                    child: Text(
                      'Join for seva',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  FutureBuilder<List<Seva>>(
                    future: fetchSeva(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show loading indicator
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Sevas available'));
                      } else {
                        // Data is fetched successfully
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CarouselSlider.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index, realIndex) {
                              final seva = snapshot.data![index];
                              // Replace the placeholder widget with your actual widgets
                              return Container(
                                width: 377,
                                decoration: BoxDecoration(
                                  color: HexColor('FFE5D0'),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(seva.sevaName),
                                          // CircleAvatar(
                                          //   backgroundColor: Colors.white,
                                          //   radius: 15,
                                          //   child: Text(
                                          //     '+10',
                                          //     style: GoogleFonts.raleway(
                                          //         fontSize: 12,
                                          //         color: Colors.black),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            size: 15,
                                            color: HexColor('7B7B7B'),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            seva.time,
                                            style: GoogleFonts.raleway(
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 5),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              size: 15,
                                              color: HexColor('7B7B7B')),
                                          SizedBox(width: 5),
                                          Text(
                                            seva.venue,
                                            style: GoogleFonts.raleway(
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              padEnds: false,
                              enlargeCenterPage: false,
                              viewportFraction: 0.9,
                              aspectRatio: 2.1,
                              disableCenter: false,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              // autoPlayInterval: Duration(minutes: 1),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
