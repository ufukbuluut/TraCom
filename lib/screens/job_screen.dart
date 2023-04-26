import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracom/screens/StudentProfile.dart';
import 'package:tracom/user_state.dart';
import 'package:tracom/widgets/bottom_nav_bar.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarForApp(indexNum :0),
      appBar: AppBar(
        title: const Text('Deneme Sayfası'),
      ),
      
    );
  }
}
