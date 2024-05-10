import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  // Add more controllers for other fields
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var uri = Uri.parse('http://your-domain.com/signup.php'); // Change to your actual URL
      var request = http.MultipartRequest('POST', uri);
      request.fields['email'] = _emailController.text;
      request.fields['phone_number'] = _phoneNumberController.text;
      request.fields['name'] = _nameController.text;
      // Include other fields similarly

      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath('profile_picture', _image!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseData);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(decodedResponse['message']),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("Failed to register user"),
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup Form")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone Number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 10),
                _image == null ? Text("No image selected") : Image.file(File(_image!.path)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: Text(_isLoading ? 'Loading...' : 'Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
