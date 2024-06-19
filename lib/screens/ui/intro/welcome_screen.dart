import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jb_user_app/screens/ui/intro/enter_basic-1.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';
  bool isOtpSent = false;
  bool isLoading = false;
  String errorMessage = '';
  String selectedCountryCode = '+91';

  void sendOtp() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '$selectedCountryCode${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BasicDetailsPage1()));
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            errorMessage = 'Verification failed. Please try again.';
            isLoading = false;
          });
          if (e.code == 'invalid-phone-number') {
            setState(() {
              errorMessage = 'The provided phone number is not valid.';
            });
          } else if (e.code == 'too-many-requests') {
            setState(() {
              errorMessage = 'Too many requests. Please try again later.';
            });
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
            isOtpSent = true;
            isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to send OTP. Please try again.';
        isLoading = false;
      });
    }
  }

  void verifyOtp() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );

      await _auth.signInWithCredential(credential);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BasicDetailsPage1()));
    } catch (e) {
      setState(() {
        errorMessage = 'Invalid OTP. Please try again.';
        isLoading = false;
      });
    }
  }

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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/jb_admin_main_page.png',
                      width: 149,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Welcome to Team Happiness',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            child: DropdownButtonFormField<String>(
                              value: selectedCountryCode,
                              items: [
                                DropdownMenuItem(
                                  child: Text('+91'),
                                  value: '+91',
                                ),
                                DropdownMenuItem(
                                  child: Text('+1'),
                                  value: '+1',
                                ),
                                // Add more country codes as needed
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedCountryCode = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Enter your phone number',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isOtpSent)
                        TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Enter OTP',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: isOtpSent ? verifyOtp : sendOtp,
                  child: Container(
                    width: 219,
                    height: 58,
                    decoration: BoxDecoration(
                      color: HexColor('EF6C00'),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              isOtpSent ? 'Verify OTP' : 'Send OTP',
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
