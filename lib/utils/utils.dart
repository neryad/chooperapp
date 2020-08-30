import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

bool isEmpty(String s) {
  return (s == "") ? false : true;
}

void showSnack(BuildContext context, String msg) {
  Flushbar(
    message: msg,
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue,
    ),
    leftBarIndicatorColor: Colors.blue,
    duration: Duration(seconds: 2),
  )..show(context);
}
