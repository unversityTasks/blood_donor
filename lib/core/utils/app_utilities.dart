

import 'package:blood_donor/core/components/app_text.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';


class AppUtil {
  static final RegExp emailValidatorRegExp =
      RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-_]+\.[a-zA-Z0-9-.]+$)");
  static final RegExp phoneValidatorRegExp = RegExp(r'^\+[0-9]{10,}$');

  static Widget emptyLottie({height, top}) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: top ?? 12.h),
          child:const CircularProgressIndicator(),
        ),
      );

  

  static Future appDialoge(
      {BuildContext? context, Widget? content,Widget?child, String? title}) async {
    return await showDialog(
      barrierDismissible: false,
        context: context!,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, builder) {
            return AlertDialog(

              
              contentPadding: EdgeInsets.zero,
              title:  title==null?child:AppText(
                title,
              ),
              content: content,
            );
          });
        });
  }

 
  static Widget appLoader({height,top}) => Column(
    children: [
      if(top!=null)
      SizedBox(height: top,),
     const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
    ],
  );

  
}
