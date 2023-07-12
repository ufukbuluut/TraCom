import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tracom/screens/StudentProfile.dart';
import 'package:tracom/screens/add_advert.dart';
import 'package:tracom/screens/messages.dart';
import 'package:tracom/screens/offers_view.dart';
import 'package:tracom/user_state.dart';
import 'package:tracom/widgets/AppText.dart';

// ignore: must_be_immutable
class BottomNavigationBarForApp extends StatelessWidget {
  int indexNum = 0;
  BottomNavigationBarForApp({required this.indexNum});

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 241, 243, 246),
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AppText(
                      text: 'Sign Out',
                      size: 28,
                      color: Colors.black,
                    ))
              ],
            ),
            content: AppText(
              text: 'Do you want to sign out?',
              size: 20,
              color: Colors.black,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('No',
                    style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => UserState()));
                },
                child: const Text('Yes',
                    style: TextStyle(color: Colors.green, fontSize: 18)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Color.fromARGB(255, 185, 217, 255),
      backgroundColor: const Color.fromARGB(255, 241, 243, 246),
      buttonBackgroundColor: Color.fromARGB(255, 185, 217, 255),
      height: 50,
      index: indexNum,
      items: const [
        Icon(
          Icons.list,
          size: 19,
          color: Colors.black,
        ),
        Icon(
          Icons.message,
          size: 19,
          color: Colors.black,
        ),
        Icon(
          Icons.add,
          size: 19,
          color: Colors.black,
        ),
        Icon(
          Icons.person_pin,
          size: 19,
          color: Colors.black,
        ),
        Icon(
          Icons.exit_to_app,
          size: 19,
          color: Colors.black,
        )
      ],
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => OffersView()));
        } else if (index == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MessagesScreen()));
        } else if (index == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Adverts()));
        } else if (index == 3) {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          final User? user = _auth.currentUser;
          final String uid = user!.uid;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => StudentProfile(
                        userID: uid,
                      )));
        } else if (index == 4) {
          _logout(context);
        }
      },
    );
  }
}
