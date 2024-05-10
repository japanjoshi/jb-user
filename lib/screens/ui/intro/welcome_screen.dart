import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:jb_user_app/screens/main_screen.dart'; // Update with your main screen

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PhoneNumber? phoneNumber;
  final supabaseClient = Supabase.instance.client;

  /// Finds or creates a user based on phone number and establishes a session
  Future<void> findOrCreateUser(String phoneNumber) async {
    // Attempt to find the user by their phone number
    final response = await supabaseClient
        .from('users')
        .select('id')
        .eq('phone_number', phoneNumber)
        .maybeSingle();

    if (response != null && response.isNotEmpty) {
      // If the phone number is found, consider the user already logged in
      print('Phone number found. Logging in.');
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const MainScreen()), // Replace with your main screen widget
      // );
    } else {
      // Insert a new user with this phone number
      final insertResponse = await supabaseClient
          .from('users')
          .insert({'phone_number': phoneNumber});

      if (insertResponse.error != null) {
        print('Error creating new user: ${insertResponse.error!.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${insertResponse.error!.message}')),
        );
      } else {
        print('User created successfully with phone number.');
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           const MainScreen()), // Navigate to main screen
        // );
      }
    }
  }

  /// Logic to handle phone number-based authentication
  void _continue() async {
    if (phoneNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    // Retrieve the phone number as a string
    final String phone = phoneNumber!.phoneNumber ?? '';

    // Find or create the user with this phone number
    await findOrCreateUser(phone);
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Icon(
                      Icons.spa_outlined,
                      color: Colors.orangeAccent,
                      size: 120,
                    ),
                  ),
                ),
                Text(
                  'Welcome to Team Happiness',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 100, bottom: 70),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      phoneNumber = number;
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      showFlags: false,
                    ),
                    initialValue: PhoneNumber(isoCode: 'IN'),
                    inputDecoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _continue,
                  child: Container(
                    width: 219,
                    height: 58,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
