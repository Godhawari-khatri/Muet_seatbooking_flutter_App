import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_seat_booking_app/firebase_auth.dart';
import 'package:online_seat_booking_app/login-page.dart';


class Signup extends StatefulWidget {
  final Key? key; 

  Signup({this.key}) : super(key: key);
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<Signup> {
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("users");





Future<bool> isEmailAlreadyRegistered(String email) async {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: email).get();

  return snapshot.docs.isNotEmpty; 
}


signUp() async {
  final AuthService authService = AuthService();
  String email = emailController.text;
  String password = passwordController.text;
  String name = nameController.text;
  String age = ageController.text;

  if (email.isEmpty || password.isEmpty || name.isEmpty || age.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter all details.")),
    );
    return; // Exit the method if any field is empty.
  }

  if (await isEmailAlreadyRegistered(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("This email is already registered.")),
    );
  } else {
    String info = await authService.signUp(email, password);
    users.add({"name": name, "age": age, "email": email});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(info)),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
          backgroundColor: Color.fromARGB(
            247, 41, 55, 83),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                   decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(247, 41, 55, 83), 
                          ),
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Color.fromARGB(247, 41, 55, 83),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(247, 41, 55, 83),
                              
                            ),
                          ),
                        ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                          labelText: 'Age',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(247, 41, 55, 83), 
                          ),
                          prefixIcon: Icon(Icons.scale_outlined),
                          prefixIconColor: Color.fromARGB(247, 41, 55, 83),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(247, 41, 55, 83),
                              
                            ),
                          ),
                        ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your age';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(247, 41, 55, 83), 
                          ),
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Color.fromARGB(247, 41, 55, 83),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(247, 41, 55, 83),
                             
                            ),
                          ),
                        ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(247, 41, 55, 83), 
                          ),
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Color.fromARGB(247, 41, 55, 83),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(247, 41, 55, 83),
                              
                            ),
                          ),
                        ),
                    validator: (value) {
                      bool passValid = RegExp(
                              "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                          .hasMatch(value!);
                      if (value.isEmpty || !passValid) {
                        return "Please Enter a valid password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  
                  SizedBox(height: 20),
                 ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                       
                       
                      }
                      signUp();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                    child: const Text('save'),
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
