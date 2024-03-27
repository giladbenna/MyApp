import 'package:flutter/material.dart';
import 'package:my_app/views/MenuPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false; // State to keep track of the checkbox status
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView for better responsiveness
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/login_picture.png', // Path to your image asset
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 20), // Space between the image and the text
              // Centered Text
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'MyCustomFont',
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'We Will Be Happy To Know You',
                style: TextStyle(
                  fontFamily: 'MyCustomFont',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height:
                      20), // Space between the text and the first text field
              // Text Fields with full borders, black and rounded corners
              TextField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    // Full border
                    borderSide: BorderSide(color: Colors.black), // Black border
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between text fields
              TextField(
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20), // Add space before the CheckboxListTile
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "I agree to the terms",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.info, color: Colors.grey),
                  SizedBox(width: 150),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                    shape:
                        CircleBorder(), // Gives a more rounded shape to the checkbox
                  ),
                ],
              ),
              SizedBox(height: 20), // Add space before the CheckboxListTile

              // Login button
              ElevatedButton(
                onPressed: () {
                  if (_isChecked) {
                    // If the checkbox is checked, navigate to the MenuPage
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              MenuPage()), // Make sure MenuPage is correctly imported
                    );
                  } else {
                    // If the checkbox is not checked, show a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please agree to the terms to continue.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text color
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
