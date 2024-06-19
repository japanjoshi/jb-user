import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jb_user_app/screens/home_kriya.dart';

import 'package:jb_user_app/screens/ui/toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({super.key});

  @override
  State<MyProgress> createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  CustomToast _toast = CustomToast();
  var box = Hive.box('home_kriya_count');
  String userName = ""; // State variable to store user's name

  Future<void> fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;

    try {
      if (user != null) {
        final response = await Supabase.instance.client
            .from('users')
            .select()
            .single()
            .limit(1);

        setState(() {
          userName = response['name'] as String;
        });
        print(userName);
      }
    } on PostgrestException catch (error) {
      print(error.message);
    } finally {
      print("success");
    }
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
            appBar: AppBar(
              toolbarHeight: 50,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: null,
                  child: Text(
                    'LOGOUT',
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      color: HexColor('FF9D3F'),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: HexColor('EF6C00'),
                      radius: 50,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName.toString(),
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 86,
                              height: 83,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor('FFAB65'),
                                    HexColor('DD7E30')
                                  ],
                                ),
                              ),
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: box.listenable(),
                                  builder: (context, Box value, child) => Text(
                                    value.getAt(0).toString(),
                                    style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 27),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Home Kriya',
                              style: GoogleFonts.raleway(
                                color: HexColor('7B7B7B'),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 104,
                              height: 101,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor('FFAB65'),
                                    HexColor('DD7E30')
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '0',
                                  style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 27),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Long Kriya',
                              style: GoogleFonts.raleway(
                                color: HexColor('7B7B7B'),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 86,
                              height: 83,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor('FFAB65'),
                                    HexColor('DD7E30')
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '0',
                                  style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 27),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Total Seva',
                              style: GoogleFonts.raleway(
                                color: HexColor('7B7B7B'),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25.0, left: 20, right: 20),
                    child: Card(
                      color: HexColor('FFE2CC').withOpacity(1),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Quick Actions',
                              style: GoogleFonts.raleway(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: HexColor('B53D00'),
                              ),
                            ),
                          ),
                          SizedBox(height: 34),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeKriya(),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: HexColor('B53D00'),
                                      radius: 30,
                                      child: Icon(
                                        Icons.self_improvement,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Home Kriya',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _toast.showToast(
                                          context,
                                          'Long Kriya QR Scanner will be available on Sunday',
                                          Colors.grey);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: HexColor('B53D00'),
                                      radius: 30,
                                      child: Icon(
                                        Icons.qr_code_scanner_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Long Kriya',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor('B53D00'),
                                    radius: 30,
                                    child: Icon(
                                      Icons.volunteer_activism,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'My Sevas',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 34),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor('B53D00'),
                                    radius: 30,
                                    child: Icon(
                                      Icons.event_available,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'My Events',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor('B53D00'),
                                    radius: 30,
                                    child: Icon(
                                      Icons.person_add,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Add Reference',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: HexColor('B53D00'),
                                    radius: 30,
                                    child: Icon(
                                      Icons.contact_support,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Feedback',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 34),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
