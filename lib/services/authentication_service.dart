import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String?> sendOtp(String phoneNumber) async {
    String? verificationId;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          // Auto-retrieval or instant verification has been triggered.
          // You can sign in the user directly if needed.
        },
        verificationFailed: (FirebaseAuthException exception) {
          print('Verification failed: ${exception.message}');
        },
        codeSent: (String sentVerificationId, int? forceResendingToken) {
          verificationId = sentVerificationId;
        },
        codeAutoRetrievalTimeout: (String sentVerificationId) {
          verificationId = sentVerificationId;
        },
      );
    } catch (e) {
      print('Error occurred while sending OTP: $e');
    }
    return verificationId;
  }

  static Future<bool> verifyOtp(String verificationId, String smsCode) async {
    bool success = false;
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        success = true;
      }
    } catch (e) {
      print('Error occurred during OTP verification: $e');
    }
    return success;
  }
}
