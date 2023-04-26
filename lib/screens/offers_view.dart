import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracom/screens/extension.dart';
import 'package:tracom/widgets/offer_widget.dart';

import '../widgets/bottom_nav_bar.dart';

class OffersView extends StatefulWidget {
  const OffersView({
    Key? key,
  }) : super(key: key);

  final String avatarImage =
      "https://e7.pngegg.com/pngimages/183/595/png-clipart-profession-computer-icons-job-teacher-avatar-profile-avatar-blue-logo.png";
  final String aboutMe =
      "Lorem ipsum dolor sit amet, consec.Lorem ipsum dolor sit amet, consec.Lorem ipsum dolor sit amet, consec.";
  final String avatarName = "Julia Albert";
  final String avatarLocation = "İstanbul, Turkey";
  final String date = "10 Aralık";
  final int itemCount = 2;

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtility().maincolor,
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
        bottomNavigationBar: BottomNavigationBarForApp(indexNum: 0),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('offers')
                .orderBy('createdAt', descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data?.docs.isNotEmpty == true) {
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OfferWidget(
                          country: snapshot.data?.docs[index]['country'],
                          ofTitle: snapshot.data?.docs[index]['ofTitle'],
                          ofDescription: snapshot.data?.docs[index]
                              ['ofDescription'],
                          ofID: snapshot.data?.docs[index]['ofID'],
                          ofDate: snapshot.data?.docs[index]['ofDate'],
                          uploadedBy: snapshot.data?.docs[index]['uploadedBy'],
                          userImage: snapshot.data?.docs[index]['userImage'],
                          name: snapshot.data?.docs[index]['name'],
                          email: snapshot.data?.docs[index]['email'],
                          location: snapshot.data?.docs[index]['location'],
                        );
                      });
                } else {
                  return const Center(
                    child: Text('There is no jobs'),
                  );
                }
              }
              return Center(
                child: Text('Something Went Wrong'),
              );
            }));
  }

  // ignore: non_constant_identifier_names
  Row RowUtility(String text, String iconPath) {
    return Row(children: [
      Image.asset(iconPath),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
          ),
        ),
      )
    ]);
  }

  // ignore: non_constant_identifier_names

  Text appTitle() {
    return Text(
      ProjectStrings().appTitle,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.408,
      ),
    );
  }
}

class ColorUtility {
  final Color maincolor = const Color.fromARGB(255, 241, 243, 246);
  final Color cardcolor = const Color.fromARGB(255, 251, 251, 251);
}

class ProjectStrings {
  final String appTitle = "Adverts";
  final String appTitle2 = "Add Advert";
  final String appTitle3 = "Profile";
  final String locationIcon = "img/location.png";
  final String dateIcon = "img/date.png";
}

class ProjectIcons {
  Icon appLeftIcon = const Icon(
    Icons.arrow_back,
    color: Colors.black,
    size: 27,
  );

  Padding appThreePointIcon = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.0),
    child: Icon(
      Icons.more_horiz_outlined,
      color: Colors.black,
      size: 27,
    ),
  );
}

class CardDetails {
  NetworkImage avatarimage(String url) {
    return NetworkImage(url);
  }

  Container DetailButton() {
    return Container(
      alignment: Alignment.topCenter,
      child: TextButton(
        onPressed: () {},
        child: Text("Detayları Görüntüle",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontWeight: FontWeight.w300,
              fontSize: 10,
              fontStyle: FontStyle.normal,
            )),
      ),
    );
  }

  Container aboutMeText(String text) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  CircleAvatar avatarImage(String imagePath) {
    return CircleAvatar(
      
      backgroundImage: CardDetails().avatarimage(imagePath),
    );
  }

  Padding avatarName(String AvatarName) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        AvatarName,
        style: GoogleFonts.poppins(
          fontStyle: FontStyle.normal,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

Container bottomNagivationBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    width: context.dynamicWidth(359),
    height: context.dynamicHeight(72),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        iconBottom(BottomIcons[0]),
        iconBottom(BottomIcons[1]),
        iconBottom(BottomIcons[2]),
        iconBottom(BottomIcons[3]),
        iconBottom(BottomIcons[4]),
      ],
    ),
  );
}

IconButton iconBottom(Icon icon) {
  return IconButton(
    onPressed: () {},
    icon: icon,
  );
}

List<Icon> BottomIcons = [
  Icon(
    Icons.home_filled,
    color: Colors.blueGrey,
  ),
  Icon(
    Icons.location_on_sharp,
    color: Colors.blueGrey,
  ),
  Icon(
    Icons.mail,
    color: Colors.blueGrey,
  ),
  Icon(
    Icons.favorite,
    color: Colors.blueGrey,
  ),
  Icon(
    Icons.account_circle,
    color: Colors.blueGrey,
  )
];
