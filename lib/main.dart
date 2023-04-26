import 'package:flutter/material.dart';
import 'package:tracom/LoginPage/login_screen.dart';
import 'package:tracom/screens/login_screen.dart';
import 'package:tracom/screens/offers_view.dart';
import 'package:tracom/screens/register_screen.dart';
import 'package:tracom/screens/student_register_screen.dart';
import 'package:tracom/screens/student_register_screen2.dart';
import 'package:tracom/screens/welcome_page.dart';
import 'package:tracom/screens/welcome_page_student.dart';
import 'package:tracom/screens/welcome_page_tourist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tracom/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) 
        {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    'TraCom App Being Initalization',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    'an error has been occured',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TraCom',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: UserState(),
          );
        }
        );
  }
}
