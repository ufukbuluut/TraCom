import 'package:flutter/material.dart';
import 'package:tracom/screens/StudentProfile.dart';
import 'package:tracom/screens/register_screen.dart';
import 'package:tracom/widgets/AppText2.dart';
import 'package:tracom/widgets/ReUsableTextFormField.dart';

class StudentRegisterScreen2 extends StatefulWidget {
  const StudentRegisterScreen2({Key? key}) : super(key: key);

  @override
  State<StudentRegisterScreen2> createState() => _StudentRegisterScreen2State();
}

class _StudentRegisterScreen2State extends State<StudentRegisterScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: 252,
            height: 52,
            margin: EdgeInsets.only(left: 12, top: 80),
            child: AppText2(
              text: "Kısaca Kendinizi Tanıtınız",
              size: 20,
            ),
          ),
          Form(
            child: Column(
              children: [
                Container(
                  width: 343,
                  height: 123,
                  margin: EdgeInsets.fromLTRB(24, 15, 23, 0),
                  child: ReUsableTextFormField(
                    hintText: "Hakkımda",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(339, 56, 30, 55),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())),
              child: Image.asset("img/arrow_right.png"),
            ),
          ),
        ],
      ),
    );
  }
}
