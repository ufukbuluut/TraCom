import 'dart:ui';
import 'package:flutter/material.dart';

class TouristProfile extends StatefulWidget {
  const TouristProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<TouristProfile> createState() => _TouristProfileState();
}

class _TouristProfileState extends State<TouristProfile> {
  var about_me =
      "I am from England, i live in Canada. It is my first time in Turkey. I love to visit historical places and I am also very curious about Turkish food.";
  var avatar_pic = "images/Alice.png";
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height / 844;
    final double deviceWidth = MediaQuery.of(context).size.width / 390;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: deviceHeight * 19),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 75, 147, 255),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(deviceHeight * 60),
              ),
            ),
            width: deviceWidth * 390,
            height: deviceHeight * 180,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: deviceHeight * 20,
                  ),
                ),
                Container(
                  width: deviceWidth * 63,
                  height: deviceHeight * 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(avatar_pic),
                ),
                Padding(
                  padding: EdgeInsets.only(left: deviceWidth * 16.0),
                  child: SizedBox(
                    width: deviceWidth * 239,
                    height: deviceHeight * 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Students to Match",
                          style: TextStyle(
                            fontSize: deviceHeight * 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Text(
                          "Fill in the required fields so that we can find the right student for you.",
                          style: TextStyle(
                            fontSize: deviceHeight * 14,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 226, 226, 226),
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: deviceHeight * 19),
            height: deviceHeight * 126,
            width: deviceWidth * 355,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 242, 241),
              borderRadius: BorderRadius.circular(deviceHeight * 24),
              boxShadow: [
                BoxShadow(
                  blurRadius: deviceHeight * 4,
                  offset: Offset(0.0, deviceHeight * 4.0),
                  color: Color.fromARGB(25, 0, 0, 0),
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: deviceHeight * 19),
            height: deviceHeight * 145,
            width: deviceWidth * 355,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 242, 241),
              borderRadius: BorderRadius.circular(deviceHeight * 24),
              boxShadow: [
                BoxShadow(
                  blurRadius: deviceHeight * 4,
                  offset: Offset(0.0, deviceHeight * 4.0),
                  color: Color.fromARGB(25, 0, 0, 0),
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: deviceHeight * 19),
            height: deviceHeight * 70,
            width: deviceWidth * 355,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 242, 241),
              borderRadius: BorderRadius.circular(deviceHeight * 24),
              boxShadow: [
                BoxShadow(
                  blurRadius: deviceHeight * 4,
                  offset: Offset(0.0, deviceHeight * 4.0),
                  color: Color.fromARGB(25, 0, 0, 0),
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: deviceHeight * 19),
            height: deviceHeight * 140,
            width: deviceWidth * 355,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 242, 241),
              borderRadius: BorderRadius.circular(deviceHeight * 24),
              boxShadow: [
                BoxShadow(
                  blurRadius: deviceHeight * 4,
                  offset: Offset(0.0, deviceHeight * 4.0),
                  color: Color.fromARGB(25, 0, 0, 0),
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: deviceHeight * 19),
              height: deviceHeight * 55,
              width: deviceWidth * 343,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 63, 125, 253),
                borderRadius: BorderRadius.circular(deviceHeight * 30),
              ),
              child: Text(
                "Contiune",
                style: TextStyle(
                  fontSize: deviceHeight * 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
