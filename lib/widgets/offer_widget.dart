import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracom/screens/extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/offers_view.dart';

class OfferWidget extends StatefulWidget {
  final String ofTitle;
  final String ofDescription;
  final String ofID;
  final String ofDate;
  final String uploadedBy;
  final String userImage;
  final String name;
  final String email;
  final String location;
  final String country;

  const OfferWidget({
    required this.ofTitle,
    required this.ofDescription,
    required this.ofID,
    required this.ofDate,
    required this.uploadedBy,
    required this.userImage,
    required this.name,
    required this.email,
    required this.location,
    required this.country,
  });

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorUtility().cardcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 18),
      elevation: 5,
      child: SizedBox(
        height: context.dynamicHeight(182),
        child: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: CardDetails().avatarImage(widget.userImage)),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CardDetails().avatarName(widget.name),
                        ),
                        Expanded(
                          child: RowUtility(
                              widget.country, ProjectStrings().locationIcon),
                        ),
                        Expanded(
                          child: RowUtility(
                              widget.ofDate, ProjectStrings().dateIcon),
                        ),
                      ],
                    )),
                Expanded(flex: 4, child: CardDetails().DetailButton()),
                _contactBy(
                    color: Colors.green,
                    fct: () {
                      _openWhatsAppChat();
                    },
                    icon: FontAwesome5.whatsapp),
              ],
            )),
            Expanded(flex: 0, child: CardDetails().avatarName(widget.ofTitle)),
            Expanded(child: CardDetails().aboutMeText(widget.ofDescription)),
          ],
        ),
      ),
    );
  }
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

void _openWhatsAppChat() async {
  //var url = 'https://wa.me/$phoneNumber?text=Hello';

  //launchUrlString(url);
  launchUrl(
    Uri.parse("https://api.whatsapp.com/send/?phone=$phoneNumber"),
    mode: LaunchMode.externalNonBrowserApplication,
  );
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
