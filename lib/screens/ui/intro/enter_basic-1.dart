import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jb_user_app/screens/ui/intro/enter_basic-2.dart';

class BasicDetailsPage1 extends StatefulWidget {
  @override
  State<BasicDetailsPage1> createState() => _BasicDetailsPage1State();
}

class _BasicDetailsPage1State extends State<BasicDetailsPage1> {
  bool isWillingToDonate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 50),
              Text(
                'Enter your basic details',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              buildHorizontalField('First Name', '', TextInputType.name),
              buildHorizontalField('Last Name', '', TextInputType.name),
              buildHorizontalField(
                  'Email', 'abc@example.com', TextInputType.emailAddress),
              buildHorizontalField('Age', 'age', TextInputType.number),
              buildHorizontalField(
                  'Address', 'address', TextInputType.streetAddress),
              buildHorizontalField('Area', 'area', TextInputType.text),
              buildHorizontalDropdown('Blood Gr',
                  ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']),
              buildCheckbox('Are you willing to donate blood?'),
              buildHorizontalDatePicker('Birthdate', '10/09/1999'),
              buildHorizontalField(
                  'Reference', 'enter your reference name', TextInputType.text),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BasicDetailsPage2(),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHorizontalField(
      String label, String hintText, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.raleway(
                color: HexColor('#FF8C00'), // Using HexColor for orange
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                border: UnderlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalDropdown(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.raleway(
                color: HexColor('#FF8C00'), // Using HexColor for orange
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalDatePicker(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.raleway(
                color: HexColor('#FF8C00'), // Using HexColor for orange
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: initialValue,
                border: UnderlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(1999, 9, 10),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ) ??
                    DateTime(1999, 9, 10);
                // Use the pickedDate
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckbox(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.raleway(
                color: HexColor('#FF8C00'), // Using HexColor for orange
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Checkbox(
            value: isWillingToDonate,
            onChanged: (bool? value) {
              setState(() {
                isWillingToDonate = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
