import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget customTextField(String hintText, TextEditingController controller){
  return Padding(
    padding:  EdgeInsets.symmetric(
        vertical: 8, horizontal: 24
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:TextStyle(
          color: Color(0XFFA3A3A3),
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
    ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFD4D4D4)
          ),
        ),
      ),
    ),
  );
}