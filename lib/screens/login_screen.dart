import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jb_user_app/screens/home_screen.dart';
import 'package:jb_user_app/services/authentication_service.dart';
import 'package:jb_user_app/utils/error_messages.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneNumber? phoneNumber;
  final _otpController = TextEditingController();
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              phoneNumber = number;
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: Colors.black),
            initialValue: phoneNumber,
            formatInput: false,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: OutlineInputBorder(),
          ),
          ElevatedButton(
            onPressed: () async {
              _verificationId = await AuthenticationService.sendOtp(
                  phoneNumber!.phoneNumber!);
              if (_verificationId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(ErrorMessage.failedToSendOTP)));
              }
            },
            child: Text('Send OTP'),
          ),
          TextField(
            controller: _otpController,
            decoration: InputDecoration(labelText: 'Enter OTP'),
          ),
          ElevatedButton(
            onPressed: () async {
              print(_otpController.text);
              bool success = await AuthenticationService.verifyOtp(
                  _verificationId!, _otpController.text);
              print(success);
              if (success) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(ErrorMessage.invalidOTP)));
              }
            },
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}
