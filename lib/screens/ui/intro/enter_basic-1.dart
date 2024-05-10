import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BasicDetailsPage1 extends StatefulWidget {
  const BasicDetailsPage1({super.key});

  @override
  State<BasicDetailsPage1> createState() => _BasicDetailsPage1State();
}

class _BasicDetailsPage1State extends State<BasicDetailsPage1> {
  // Controllers for each form field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();

  // Birthdate variables
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _birthdateController = TextEditingController();

  final supabaseClient = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _birthdateController.text = _formatDate(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdateController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  /// Inserts the collected data into the Supabase database
  Future<void> _insertUserDetails() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String age = _ageController.text;
    final String address = _addressController.text;
    final String area = _areaController.text;
    final String bloodGroup = _bloodGroupController.text;
    final String birthdate = _birthdateController.text;
    final String reference = _referenceController.text;

    final userData = {
      'email': _emailController.text,
    };

    // Check for required fields before submitting
    if (name.isEmpty || email.isEmpty || age.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields')),
      );
      return;
    }

    final response = await supabaseClient.from('users').insert({
      'name': name,
      'email': email,
      'age': int.tryParse(age) ?? 0, // Ensure age is an integer
      'address': address,
      'area': area,
      'blood_group': bloodGroup,
      'birthdate': birthdate,
      'reference': reference,
    });

    if (response != null) {
      print('Error inserting data: ${response}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response}')),
      );
    } else {
      print('User details inserted successfully: ${response}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details saved successfully')),
      );
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
                            'Enter your basic details',
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField('Name', _nameController),
                          _buildLabeledField('Email', _emailController,
                              'abc@example.com', TextInputType.emailAddress),
                          _buildLabeledField('Age', _ageController, 'age',
                              TextInputType.number),
                          _buildLabeledField('Address', _addressController,
                              'address', TextInputType.streetAddress),
                          _buildLabeledField('Area', _areaController, 'area',
                              TextInputType.text),
                          _buildLabeledField(
                              'Blood Gr', _bloodGroupController, 'example: B+'),
                          _buildBirthdateField(
                              'Birthdate', _birthdateController),
                          _buildLabeledField('Reference', _referenceController,
                              'enter your reference name'),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: _insertUserDetails,
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

  /// Function to build a birthdate field that shows a DatePicker dialog
  Widget _buildBirthdateField(String label, TextEditingController controller) {
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
          GestureDetector(
            onTap: () => _selectDate(context),
            child: TextFormField(
              controller: controller,
              enabled: false, // Disable direct editing
              decoration: InputDecoration(
                hintText: 'Choose a date',
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
          ),
        ],
      ),
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
