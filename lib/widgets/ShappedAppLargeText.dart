import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShappedAppLargeText extends StatelessWidget {

  final String text;
  final double size;
  final Color color;

  ShappedAppLargeText({required this.text,this.size=30, this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.satisfy(fontSize: size,fontWeight: FontWeight.w400,color: color) );
  }
}

