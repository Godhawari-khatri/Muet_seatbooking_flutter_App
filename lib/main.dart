import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_seat_booking_app/firebase_options.dart';
import 'package:online_seat_booking_app/login-page.dart';
import 'package:online_seat_booking_app/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Booking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(
            255, 12, 127, 123), 
      ),
      home: ImageScreen(title: 'MUET seat booking App',),
    //  home: MainScreen(),
    );
  }
}

class ImageScreen extends StatefulWidget {
const ImageScreen({super.key, required this.title});
  final String title;
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
    
    
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BackgroundScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor:  Color(0xFF44474C),
      ),

    body: Center(
  child: Container(
    color: Color(0xFF44474C),
    constraints: BoxConstraints.expand(),
    child: Transform.scale(
      scale: 2.0,
      child: Image.asset(
        'assets/images/logo1.png',
        fit: BoxFit.contain,
      ),
    ),
  ),
)

    );
  }
}

class BackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MUET seat booking App'),
        backgroundColor: Color.fromARGB(
            247, 41, 55, 83), 
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment
            .bottomCenter, 
        child: FloatingActionButton(
          onPressed: () {
           
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SignUpLoginScreen(), 
              ),
            );
          },
          backgroundColor: Color.fromARGB(247, 216, 90,
              45), 
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class SignUpLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up & Login'),
         backgroundColor: Color.fromARGB(
            247, 41, 55, 83),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signup(),
                  ),
                );
                
              },
              style: ElevatedButton.styleFrom(
                primary:  Color.fromARGB(
                          247, 41, 55, 83), 
                onPrimary: Colors.white, 
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18, 
                ),
              ),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                
              },
              style: ElevatedButton.styleFrom(
                primary:  Color.fromARGB(
                          247, 41, 55, 83), 
                onPrimary: Colors.white, 
                padding: EdgeInsets.symmetric(horizontal: 42, vertical: 20), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

