import 'package:flutter/material.dart';
import 'package:tracom/screens/student_register_screen2.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:tracom/widgets/AppText2.dart';
import 'package:tracom/widgets/ReUsableTextFormField.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({Key? key}) : super(key: key);

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 119, right: 170),
              child: AppText2(
                text: "İsminizi Giriniz",
                size: 20,
              ),
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(24, 15, 23, 0),
                    child: ReUsableTextFormField(
                      hintText: "İsminiz",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 31, top: 84, right: 100),
                    child: AppText2(
                      text: "Okul mail adresinizi giriniz",
                      size: 20,
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(24, 15, 23, 0),
                    child: ReUsableTextFormField(
                      hintText: "yourname@edu.tr",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110, right: 170),
                    child: AppText2(
                      text: "Şifrenizi giriniz",
                      size: 20,
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(24, 15, 23, 0),
                    child: ReUsableTextFormField(
                      hintText: "Password",
                      obsecure: true,
                      suffix: Container(
                          margin:
                              EdgeInsets.only(top: 20, right: 21, bottom: 20),
                          child: AppText(
                            text: "Show",
                            color: Color(0xff57C3FF),
                            size: 11,
                          )),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(24, 18, 23, 0),
                    child: ReUsableTextFormField(
                      hintText: "Confirm Password",
                      obsecure: true,
                      suffix: Container(
                        margin: EdgeInsets.only(top: 20, right: 21, bottom: 20),
                        child: AppText(
                          text: "Show",
                          color: Color(0xff57C3FF),
                          size: 11,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(339, 56, 30, 55),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentRegisterScreen2())),
                      child: Image.asset("img/arrow_right.png"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
