import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class GlobalTextField extends StatelessWidget {
  final control;
  final validation;
  final String? hint;
  final TextInputAction? textInputAction;
  final bool secure;

  GlobalTextField(
    this.control,
    this.validation,
    this.hint,
    this.textInputAction,
    this.secure,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: Get.width,
      child: TextFormField(
        obscureText: secure,
        controller: control,
        validator: validation,
        textInputAction: textInputAction,
        style: TextStyle(color: Colors.white, fontSize: 11),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(45, 47, 58, 1),
          contentPadding: EdgeInsets.all(10.0),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white38),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
