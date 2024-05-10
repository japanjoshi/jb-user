import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToast {
  FToast? fToast;

  void showToast(BuildContext context, String content, Color color,
      {int duration = 5}) {
    fToast = FToast().init(context);

    fToast!.showToast(
      child: Container(
        width: 201.w,
        height: 38.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: color,
        ),
        child: Center(
          child: Text(
            content,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }
}
