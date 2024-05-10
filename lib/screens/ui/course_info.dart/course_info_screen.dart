import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jb_user_app/models/course_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({super.key, this.course});

  final Course? course;

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  openWhatsApp() async {
    var whatsapp = "+918866115862";
    var whatsappUrlAndroid =
        Uri.parse("whatsapp://send?text=sample text&phone=918866115862");
    var whatsappUrlIOS = Uri.parse(
        "https://wa.me/$whatsapp?text=${Uri.encodeComponent("hello")}");

    if (Platform.isIOS) {
      if (await canLaunchUrl(whatsappUrlIOS)) {
        await launchUrl(whatsappUrlIOS, mode: LaunchMode.externalApplication);
      } else {
        print("WhatsApp is not installed");
      }
    } else {
      launch(
          'whatsapp://send?text=${'Hello, I am interested in joining *${widget.course!.name}*'} text&phone=918866115862');
      // if (await canLaunchUrl(whatsappUrlAndroid)) {
      //   await launchUrl(whatsappUrlAndroid,
      //       mode: LaunchMode.externalApplication);
      // } else {}
    }
  }

  launchWhatsAppUri() async {
    final link = WhatsAppUnilink(
      phoneNumber: '918866115862',
      text: "Hey! I am interested in registering for  ${widget.course!.name}",
    );
    // Convert the WhatsAppUnilink instance to a Uri.
    // The "launch" method is part of "url_launcher".
    await launchUrl(link.asUri());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 72,
          child: Row(
            children: [
              Container(
                height: 72,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    'DIRECTIONS',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchWhatsAppUri();
                },
                child: Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Center(
                    child: Text(
                      'JOIN EVENT',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        backgroundColor: HexColor('F4EEE9'),
        // appBar: AppBar(
        //   toolbarHeight: 190,
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.transparent,
        //   actions: [],
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 231,
              child: Image.network(
                widget.course!.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 27, bottom: 16),
                      child: Text(
                        widget.course!.name,
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: HexColor('B53D00'),
                          ),
                          SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              widget.course!.venue,
                              style: GoogleFonts.raleway(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 20,
                                    color: HexColor('B53D00'),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    widget.course!.date,
                                    style: GoogleFonts.raleway(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: HexColor('B53D00'),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.course!.time,
                                    style: GoogleFonts.raleway(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 10),
              height: 140,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Have Questions?',
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 2, left: 10),
                    child: Text(
                      'Contact our volunteers',
                      style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              widget.course!.contactName,
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0, left: 10),
                            child: Text(
                              widget.course!.number,
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          launch('tel://+918866115862');
                          // final Uri url =
                          //     Uri(scheme: 'tel', path: '+918866115862');
                          // if (await canLaunchUrl(url)) {
                          //   await launchUrl(url);
                          // } else {
                          //   print('Could not launch $url');
                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.phone_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
