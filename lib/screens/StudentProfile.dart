import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Services/global_variables.dart';
import '../widgets/bottom_nav_bar.dart';
import 'add_advert.dart';
import 'offers_view.dart';

class StudentProfile extends StatefulWidget {
  final String userID;
  const StudentProfile({required this.userID});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? name;
  String? lastName;
  String email = '';
  String phoneNumber = '';
  String imageUrl = '';
  String joinedAt = '';
  String location = '';
  bool _isLoading = false;
  bool _isSameUser = false;

  void getUserData() async {
    // ignore: empty_catches
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          name = userDoc.get('name');
          lastName = userDoc.get('lastName');
          email = userDoc.get('email');
          location = userDoc.get('location');
          imageUrl = userDoc.get('userImage');
          phoneNumber = userDoc.get('phoneNumber');
          Timestamp joinedAtTimeStamp = userDoc.get('createdAt');
          var joinedDate = joinedAtTimeStamp.toDate();
          joinedAt =
              '${joinedDate.year} - ${joinedDate.month} - ${joinedDate.day}';
        });
        User? user = _auth.currentUser;
        final _uid = user!.uid;
        setState(() {
          _isSameUser = _uid == widget.userID;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Widget _contactBy(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              fct();
            },
            icon: Icon(
              icon,
              color: color,
            )),
      ),
    );
  }

  void _openWhatsAppChat() async {
    //var url = 'https://wa.me/$phoneNumber?text=Hello';

    //launchUrlString(url);
    launchUrl(
      Uri.parse("https://api.whatsapp.com/send/?phone=$phoneNumber"),
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }

  void _callPhoneNumber() async {
    var url = 'tel:+$phoneNumber';
    launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height / 844;
    final double deviceWidth = MediaQuery.of(context).size.width / 390;
    var username = name! + ' ' + lastName!;
    var lastname = lastName!;
    var userinfo = location;
    var aboutMe =
        "Thank you for your hard work on this project. We look forward to working with you again in the future.";

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBarForApp(indexNum: 3),
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
        body: SingleChildScrollView(
          child: Container(
            width: deviceWidth * 390,
            height: deviceHeight * 844,
            child: Column(
              children: [
                StackTop(
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  imgUrl: imageUrl,
                ),
                const SizedBox(height: 8),
                Text(username,
                    style: ProjectTextStyle.UserNameTextStyle(deviceHeight)),
                Text(
                  userinfo,
                  style: ProjectTextStyle.UserInfoTextStyle(
                      deviceWidth, deviceHeight),
                ),
                AboutMe(deviceWidth: deviceWidth, deviceHeight: deviceHeight),
                AboutMeDetails(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    aboutMe: aboutMe),
                ContactMe(deviceWidth: deviceWidth, deviceHeight: deviceHeight),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _contactBy(
                        color: Colors.green,
                        fct: () {
                          _openWhatsAppChat();
                        },
                        icon: FontAwesome5.whatsapp),
                    _contactBy(
                        color: Colors.blue,
                        fct: () {
                          _callPhoneNumber();
                        },
                        icon: Icons.call),
                  ],
                ),
                TextBaslikLanguage(
                    deviceWidth: deviceWidth, deviceHeight: deviceHeight),
                LanguageDetails(
                    deviceWidth: deviceWidth, deviceHeight: deviceHeight),
                Comments(deviceWidth: deviceWidth, deviceHeight: deviceHeight),
              ],
            ),
          ),
        ));
  }
}

class StackTop extends StatefulWidget {
  const StackTop(
      {Key? key,
      required this.deviceWidth,
      required this.deviceHeight,
      required this.imgUrl})
      : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final String imgUrl;

  @override
  State<StackTop> createState() => _StackTopState();
}

class _StackTopState extends State<StackTop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ProjectColors.AppBar,
            borderRadius: BorderRadius.only(
              bottomLeft:
                  RadiusProject(widget.deviceWidth, widget.deviceHeight),
              bottomRight: RadiusProject(
                widget.deviceWidth,
                widget.deviceHeight,
              ),
            ),
          ),
          height: widget.deviceHeight * 100,
          width: widget.deviceWidth * 390,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: widget.deviceHeight * 40,
            right: widget.deviceWidth * 145,
            left: widget.deviceWidth * 145,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: ProjectColors.ScaffoldBackground,
                  width: widget.deviceWidth * 3,
                ),
                image: DecorationImage(image: NetworkImage(//widget.imgUrl == null
                    //? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                    widget.imgUrl))),
            height: widget.deviceHeight * 99,
            width: widget.deviceWidth * 100,
          ),
        )
      ],
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: deviceWidth * 24,
        right: deviceWidth * 24,
        top: deviceHeight * 15,
      ),
      width: deviceWidth * 342,
      height: deviceHeight * 104.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          deviceHeight * 18,
        ),
      ),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              height: deviceHeight * 30,
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: deviceHeight * 10, top: deviceHeight * 10),
                      height: deviceHeight * 20,
                      width: deviceHeight * 24,
                      child: Image.asset(
                        'images/logo.png',
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: deviceHeight * 10.0, left: deviceHeight * 4),
                    child: Text(
                      'Comments',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: deviceHeight * 16,
                          color: Color.fromARGB(255, 144, 152, 163)),
                    ),
                  )
                ],
              )),
          Container(
            height: 68,
            child: SingleChildScrollView(
                child: Column(
              children: [
                CommentsContainer(deviceHeight: deviceHeight),
                CommentsContainer2(deviceHeight: deviceHeight),
                CommentsContainer(deviceHeight: deviceHeight),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class CommentsContainer extends StatelessWidget {
  const CommentsContainer({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(deviceHeight * 8),
          color: ColorUtility().maincolor,
        ),
        margin: EdgeInsets.all(deviceHeight * 6),
        height: deviceHeight * 62,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://pbs.twimg.com/media/Edw83IZXYAAOyfZ?format=jpg&name=large'))),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jhon Johnson',
                    style: TextStyle(fontSize: 18),
                  ),
                  AppText(
                      text:
                          'Thank you for being able to have such an experience for one day :)',
                      size: 14)
                ],
              ),
            )
          ],
        ));
  }
}

class CommentsContainer2 extends StatelessWidget {
  const CommentsContainer2({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(deviceHeight * 8),
          color: Color.fromARGB(255, 1, 180, 180),
        ),
        margin: EdgeInsets.all(deviceHeight * 6),
        height: deviceHeight * 62,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blueGrey),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://pbs.twimg.com/media/FajkIp8XgAA_ceL?format=jpg&name=medium'))),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ali Demir',
                    style: TextStyle(fontSize: 18),
                  ),
                  AppText(text: 'Awesome Day :)', size: 16)
                ],
              ),
            )
          ],
        ));
  }
}

class LanguageDetails extends StatelessWidget {
  const LanguageDetails({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: deviceWidth * 24,
        right: deviceWidth * 24,
        top: deviceHeight * 10,
      ),
      width: deviceWidth * 342,
      height: deviceHeight * 196,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(deviceHeight * 18),
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              LanguageContainer3(deviceHeight: deviceHeight),
              LanguageContainer2(deviceHeight: deviceHeight),
              LanguageContainer(deviceHeight: deviceHeight),
            ],
          )),
    );
  }
}

class TextBaslikLanguage extends StatelessWidget {
  const TextBaslikLanguage({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: deviceWidth * 27,
        right: deviceWidth * 27,
        top: deviceHeight * 17,
      ),
      child: SizedBox(
        width: deviceWidth * 349,
        height: deviceHeight * 15,
        child: Text(
          "Yabancı Diller",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: deviceWidth * 0.2,
            fontSize: deviceHeight * 15,
            color: Color.fromARGB(255, 144, 152, 163),
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class AboutMeDetails extends StatelessWidget {
  const AboutMeDetails({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.aboutMe,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final String aboutMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: deviceWidth * 27,
        right: deviceWidth * 27,
        top: deviceHeight * 10,
      ),
      child: SizedBox(
        width: deviceWidth * 349,
        height: deviceHeight * 75,
        child: Text(
          aboutMe,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: deviceWidth * 0.2,
            fontSize: deviceHeight * 18,
            color: Color.fromARGB(255, 66, 66, 66),
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: deviceWidth * 27,
          right: deviceWidth * 27,
          top: deviceHeight * 20),
      child: SizedBox(
        width: deviceWidth * 349,
        height: deviceHeight * 22,
        child: Text(
          "About Me",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: deviceHeight * 16,
              color: Color.fromARGB(255, 144, 152, 163),
              fontStyle: FontStyle.normal),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class ContactMe extends StatelessWidget {
  const ContactMe({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: deviceWidth * 27,
          right: deviceWidth * 27,
          top: deviceHeight * 20),
      child: SizedBox(
        width: deviceWidth * 349,
        height: deviceHeight * 22,
        child: Text(
          "Contact Me",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: deviceHeight * 16,
              color: Color.fromARGB(255, 144, 152, 163),
              fontStyle: FontStyle.normal),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(deviceHeight * 8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(deviceHeight * 8),
            color: ColorUtility().maincolor,
          ),
          margin: EdgeInsets.all(deviceHeight * 6),
          height: deviceHeight * 62,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://storage.needpix.com/rsynced_images/colors-of-england.jpg'))),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [AppText(text: 'English', size: 18)],
                ),
              )
            ],
          )),
    );
  }
}

class LanguageContainer2 extends StatelessWidget {
  const LanguageContainer2({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(deviceHeight * 8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(deviceHeight * 8),
            color: ColorUtility().maincolor,
          ),
          margin: EdgeInsets.all(deviceHeight * 6),
          height: deviceHeight * 62,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Flag_of_France_%282000_World_Factbook%29.svg/1200px-Flag_of_France_%282000_World_Factbook%29.svg.png'))),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [AppText(text: 'French', size: 18)],
                ),
              )
            ],
          )),
    );
  }
}

class LanguageContainer3 extends StatelessWidget {
  const LanguageContainer3({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(deviceHeight * 8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(deviceHeight * 8),
            color: ColorUtility().maincolor,
          ),
          margin: EdgeInsets.all(deviceHeight * 6),
          height: deviceHeight * 62,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.bayspor.com/Uploads/UrunResimleri/B-2012-Alpaka-Turk-Bayragi-100x150-4fa7.png'))),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [AppText(text: 'Turkish', size: 18)],
                ),
              )
            ],
          )),
    );
  }
}

class BottomIcons extends StatelessWidget {
  const BottomIcons({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BottomEdge(deviceWidth, deviceHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            deviceHeight * 16,
          ),
        ),
        height: deviceHeight * 72,
        width: deviceWidth * 359,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home_filled,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.location_on_sharp,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.mail,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectTextStyle {
  static TextStyle UserNameTextStyle(double deviceHeight) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: deviceHeight * 20,
        fontStyle: FontStyle.normal,
        color: Color.fromARGB(255, 0, 0, 0),
      );
  static TextStyle UserInfoTextStyle(double deviceWidth, double deviceHeight) {
    return TextStyle(
      letterSpacing: deviceWidth * 0.2,
      fontSize: deviceHeight * 18,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: Color.fromARGB(255, 97, 97, 97),
    );
  }
}

EdgeInsets BottomEdge(double deviceWidth, double deviceHeight) =>
    EdgeInsets.only(
      left: deviceWidth * 14.0,
      right: deviceWidth * 14,
      top: deviceHeight * 10,
      bottom: deviceHeight * 14,
    );
Radius RadiusProject(double deviceWidth, double deviceHeight) =>
    Radius.elliptical(
      deviceWidth * 390,
      deviceHeight * 60,
    );

EdgeInsets ProjectEdgeAppBar(double deviceWidth) => EdgeInsets.only(
      right: deviceWidth * 25.0,
      left: deviceWidth * 25.0,
    );

class ProjectColors {
  static Color AppBar = const Color.fromARGB(255, 223, 241, 255);
  static Color ScaffoldBackground = Color.fromARGB(255, 241, 243, 246);
}

Text appTitle() {
  return Text(
    ProjectStrings().appTitle3,
    style: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.408,
    ),
  );
}
