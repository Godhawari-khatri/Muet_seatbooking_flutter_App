import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_seat_booking_app/firebase_auth.dart';


import 'destination.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 
Future<bool> isEmailRegistered(String email) async {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: email).get();

  return snapshot.docs.isNotEmpty; 
}
  


  
  signIn() async {
  final AuthService authService = AuthService();
  String email = emailController.text;
  String password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter both email and password.")),
    );
    return; // Exit the method if fields are empty.
  }

  if (_formKey.currentState?.validate() ?? false) {
    final String? user = await authService.signIn(email, password);

    if (!(await isEmailRegistered(email))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("This email is not registered.")),
      );
    } else {
      String info = await authService.signIn(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(info)),
      );


         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    }
  }
}


@override
  void dispose() {
    emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(
            247, 41, 55, 83), 
        title: Text(
          'Seat Booking Login',
          style: TextStyle(
            color: Colors.white, 
          ),
        ),
      ),
      body: Container(
        color: Colors.white, 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(247, 41, 55, 83), // Change the label text color
                      ),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Color.fromARGB(247, 41, 55, 83),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red, // Change the border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(247, 41, 55, 83),
                          // Change the focused border color
                        ),
                      ),
                    ),
                    cursorColor: Color.fromARGB(247, 41, 55, 83), 
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!isValidEmail(value!)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(247, 41, 55, 83), // Change the label text color
                      ),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red, // Change the border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(247, 41, 55,
                              83), // Change the focused border color
                        ),
                      ),
                      hintText: 'Enter your password',
                      prefixIconColor: Color.fromARGB(247, 41, 55, 83),
                    ),
                    cursorColor: Color.fromARGB(247, 41, 55, 83),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       
                      }
                      signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }
}
