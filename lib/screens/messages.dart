import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarForApp(indexNum: 1),
      appBar: AppBar(
        title: Text('Messages'),
      ),
    );
  }
}
