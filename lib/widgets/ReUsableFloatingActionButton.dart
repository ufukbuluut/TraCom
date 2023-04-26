import 'package:flutter/material.dart';

class ReUsableFloatingActionButton extends StatelessWidget {
  final Color backgroundColor;
  final Function? onPressed;
  final Icon icon;


  ReUsableFloatingActionButton({required this.backgroundColor, required this.onPressed, this.icon=const Icon(Icons.arrow_forward)});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed:(){},backgroundColor:backgroundColor,child: icon,);
  }
}
