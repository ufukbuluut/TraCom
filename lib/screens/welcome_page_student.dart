import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracom/screens/student_register_screen.dart';
import 'package:tracom/screens/welcome_page_tourist.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:tracom/widgets/ReUsableButton.dart';
import 'package:tracom/widgets/ReUsableFloatingActionButton.dart';
import 'package:tracom/widgets/ShappedAppLargeText.dart';

class WelcomePageStudent extends StatefulWidget {
  const WelcomePageStudent({Key? key}) : super(key: key);

  @override
  State<WelcomePageStudent> createState() => _WelcomePageStudentState();
}

class _WelcomePageStudentState extends State<WelcomePageStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(59, 49, 60, 0),
              width: 271,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/welcome_student.png"),
                      fit: BoxFit.cover))),
          Container(
            margin: EdgeInsets.only(top: 44),
            child: ShappedAppLargeText(
              text: "TraCom'a Hosgeldin!",
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 286,
            height: 135,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.dmSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: Colors.black,
                ),
                children: const [
                  TextSpan(
                    text:
                        'Ülkemize gelen turistlere bir gün boyunca eşlik ederek hem yabancı dilini geliştirmek hem de yeni tecrübeler mi edinmek istiyorsun? ',
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: MaterialButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentRegisterScreen())),
              child: ReUsableButton(
                  color: Color(0xff3F7DFD),
                  text: Container(
                      child: AppText(
                          text: "Hadi Başlayalım!",
                          color: Colors.white,
                          size: 20))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Are You Tourist?",
                  style: GoogleFonts.dmSans(fontSize: 20, color: Colors.black)),
              const TextSpan(text: '    '),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePageTourist())),
                  text: 'Get Started!',
                  style: GoogleFonts.dmSans(
                      fontSize: 20, color: Color(0xff3F7DFD)))
            ])),
          )
        ],
      ),
      floatingActionButton: ReUsableFloatingActionButton(
          backgroundColor: Color(0xff3F7DFD), onPressed: () {}),
    );
  }
}
