import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast{
  static showToast({required String msg}) {
    Fluttertoast.showToast(msg: msg);
  }

  final snackBar = SnackBar(
    content: const Text('Hi, I am a SnackBar!'),
    backgroundColor: (Colors.black12),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {
      },
    ),
  );
//  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}