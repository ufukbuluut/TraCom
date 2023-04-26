import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:tracom/widgets/ReUsableButton.dart';
import 'package:tracom/widgets/ReUsableFloatingActionButton.dart';
import 'package:tracom/widgets/ShappedAppLargeText.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("img/home.png"), fit: BoxFit.cover),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 370),
          child: Column(
            children: [
              Container(child: ShappedAppLargeText(text: "Hos Geldin!")),
              SizedBox(
                height: 22,
              ),
              Container(
                width: 286,
                height: 138,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.dmSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      height: 0.9,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Öğrenciler ile turistleri buluşturan, öğrencilerin şehirlerini yurtdışından gelenlere tanıtma fırsatı bulduğu ',
                      ),
                      TextSpan(
                        text: 'TraCom',
                        style: GoogleFonts.satisfy(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          height: 0.9,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '’a hoş geldin',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 39,
              ),
              ReUsableButton(color: Color(0xFF57C3FF),),
              SizedBox(
                height: 14,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: "Are you student?",
                      size: 20,
                      color: Colors.white,
                    ),
                    AppText(
                      text: " Get Started!",
                      color: Color(0xff57C3FF),
                      size: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 15,bottom: 15),
        child: ReUsableFloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF57C3FF),
        ),
      ),
    );
  }
}
