import 'package:flutter/material.dart';

class ReUsableTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator? validate;
  final ValueChanged? onChanged;
  final bool obsecure;
  final Widget? suffix;


  ReUsableTextFormField({this.hintText, this.controller, this.validate,
     this.onChanged, this.obsecure=false,this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      obscureText: obsecure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 1.0,color: Color(0xffE0E0E0))
        )
      ),

    );
  }
}
