import 'package:flutter/material.dart';

class ReUsableButton extends StatelessWidget {
  final Color color;
  final Widget? text;


  ReUsableButton({required this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 343,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color
      ),
      child: Center(child: text),

    );
  }
}
