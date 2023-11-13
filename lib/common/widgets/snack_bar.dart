import 'package:flutter/material.dart';

SnackBar snackBar(String text, double fontsize, int width,
    {bool isClosable = true, int microseconds = 0, int seconds = 5}) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: isClosable,
    duration: Duration(seconds: seconds, microseconds: microseconds),
    width: width - 50,
  );
}
