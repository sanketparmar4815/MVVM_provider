import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils
{
  toastMessage(String message)
  {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  flushBarErrorMessage(String message,context)
  {
    showFlushbar(context: context, flushbar: Flushbar(
    forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.all(10),
      message: message,
        borderRadius: BorderRadius.circular(10),
        duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Colors.red,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      icon: const Icon(Icons.error,size: 20,color: Colors.white,),

    )..show(context));
  }

  void fieldFocusChnage(context,FocusNode current , FocusNode next)
  {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);

  }
}