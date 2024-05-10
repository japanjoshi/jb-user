import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jb_user_app/screens/ui/intro/enter_basic-2.dart';

import 'package:jb_user_app/screens/ui/intro/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('home_kriya_count');
  await Hive.openBox('long_kriya_count');
  await Hive.openBox('total_seva_done_count');
  await Hive.openBox('lastKriyaDate');

  await Supabase.initialize(
    url: 'https://lqhvuxnsudanhtnycqkf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxxaHZ1eG5zdWRhbmh0bnljcWtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTUzMzY4MDQsImV4cCI6MjAzMDkxMjgwNH0.rKSx-7T2sv4KguSmRPzq-2__Eo4YVE88w2Y-uhC3_Pw',
  );

  if (Hive.box('home_kriya_count').length == 0) {
    Hive.box('home_kriya_count').put(0, 0);
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomeScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SignupForm(),
//     );
//   }
// }

// class SignupForm extends StatefulWidget {
//   @override
//   _SignupFormState createState() => _SignupFormState();
// }

// class _SignupFormState extends State<SignupForm> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;

//   // Controllers for each field
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _birthDateController = TextEditingController();
//   final _genderController = TextEditingController();
//   final _professionController = TextEditingController();
//   final _occupationController = TextEditingController();
//   final _hobbiesController = TextEditingController();
//   final _interestsController = TextEditingController();
//   final _healthConditionsController = TextEditingController();
//   final _goalController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _pickImage() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = pickedImage;
//     });
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       var uri = Uri.parse(
//           'http://139.59.87.58/aol/API/signup.php'); // Change to your actual URL
//       var request = http.MultipartRequest('POST', uri);

//       // Adding all the fields to the request
//       request.fields['email'] = _emailController.text;
//       request.fields['phone_number'] = _phoneNumberController.text;
//       request.fields['name'] = _nameController.text;
//       request.fields['address'] = _addressController.text;
//       request.fields['birth_date'] = _birthDateController.text;
//       request.fields['gender'] = _genderController.text;
//       request.fields['profession'] = _professionController.text;
//       request.fields['occupation'] = _occupationController.text;
//       request.fields['hobbies'] = _hobbiesController.text;
//       request.fields['intrests'] = _interestsController.text;
//       request.fields['health_conditions'] = _healthConditionsController.text;
//       request.fields['goal'] = _goalController.text;

//       // Adding the image file to the request, if selected
//       if (_image != null) {
//         request.files.add(
//             await http.MultipartFile.fromPath('profile_picture', _image!.path));
//       }

//       // Sending the HTTP request
//       var response = await request.send();

//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         var decodedResponse = json.decode(responseData);
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             content: Text(decodedResponse['message']),
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             content: Text("Failed to register user"),
//           ),
//         );
//       }

//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Signup Form")),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: <Widget>[
//                 _buildTextField(_emailController, 'Email'),
//                 _buildTextField(_phoneNumberController, 'Phone Number'),
//                 _buildTextField(_nameController, 'Name'),
//                 _buildTextField(_addressController, 'Address'),
//                 _buildTextField(_birthDateController, 'Birth Date'),
//                 _buildTextField(_genderController, 'Gender'),
//                 _buildTextField(_professionController, 'Profession'),
//                 _buildTextField(_occupationController, 'Occupation'),
//                 _buildTextField(_hobbiesController, 'Hobbies'),
//                 _buildTextField(_interestsController, 'Interests'),
//                 _buildTextField(
//                     _healthConditionsController, 'Health Conditions'),
//                 _buildTextField(_goalController, 'Goal'),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: Text('Pick Image'),
//                 ),
//                 SizedBox(height: 10),
//                 _image == null
//                     ? Text("No image selected")
//                     : Image.file(File(_image!.path)),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _submitForm,
//                   child: Text(_isLoading ? 'Loading...' : 'Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(labelText: label),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your $label';
//         }
//         return null;
//       },
//     );
//   }
// }
