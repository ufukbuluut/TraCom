import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_nav_bar.dart';
import 'StudentProfile.dart';
import 'offers_view.dart';

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
        backgroundColor: ColorUtility().maincolor,
        leading: ProjectIcons().appLeftIcon,
        elevation: 0.0,
        centerTitle: true,
        title: appTitle(),
        actions: [
          ProjectIcons().appThreePointIcon,
        ],
      ),
      backgroundColor: ProjectColors.ScaffoldBackground,
    );
  }
}

Text appTitle() {
  return Text(
    ProjectStrings().appTitle4,
    style: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.408,
    ),
  );
}
