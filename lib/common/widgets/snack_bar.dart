import 'package:flutter/material.dart';

SnackBar snackBar(String text, int seconds, double fontsize, int width) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    duration: Duration(seconds: seconds),
    width: width - 50,
  );
}
