import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class BasicDetailsPage2 extends StatefulWidget {
  final Map<String, String>? userData;
  const BasicDetailsPage2({super.key, this.userData});

  @override
  State<BasicDetailsPage2> createState() => _BasicDetailsPage2State();
}

class _BasicDetailsPage2State extends State<BasicDetailsPage2> {
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
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: HexColor('FFEFE0').withOpacity(0.9),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Tell us little more about you',
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // _buildTextField('Name', _nameController),
                          const SizedBox(height: 40),
                          GestureDetector(
                            // onTap: _insertUserDetails,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Simplified builder for fields without labels
  Widget _buildTextField(String hint, TextEditingController controller,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.only(bottom: 3),
          hintStyle: GoogleFonts.raleway(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 17,
          ),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  /// Function to build labeled fields
  Widget _buildLabeledField(
      String label, TextEditingController controller, String hint,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.raleway(
              color: HexColor('B53D00'),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              contentPadding: const EdgeInsets.only(bottom: 3),
              hintStyle: GoogleFonts.raleway(
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 12,
              ),
              border: const UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
