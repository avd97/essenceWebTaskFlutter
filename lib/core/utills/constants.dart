import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static String baseURL = 'http://192.168.3.5:3000/';
  static String userTieSVG =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#621d90" d="M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm95.8 32.6L272 480l-32-136 32-56h-96l32 56-32 136-47.8-191.4C56.9 292 0 350.3 0 422.4V464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48v-41.6c0-72.1-56.9-130.4-128.2-133.8z"/></svg>';

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
      context, String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  static void showToast(msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static void showSuccessToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.green[800],
      textColor: Colors.white,
    );
  }

  static void showFailedToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red[800],
      textColor: Colors.white,
    );
  }

  static Widget circularProgress() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: Colors.orange,
        backgroundColor: Colors.lightGreen[100],
        strokeWidth: 5,
      ),
    );
  }

  static OutlineInputBorder enabledBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
        width: 2,
        strokeAlign: 2,
      ),
    );
  }

  static OutlineInputBorder focusedBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black26,
        width: 2,
        strokeAlign: 2,
      ),
    );
  }

  static OutlineInputBorder errorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
        strokeAlign: 2,
      ),
    );
  }

  static OutlineInputBorder textFieldBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black26,
        width: 2,
        strokeAlign: 2,
      ),
    );
  }
}

enum InputTypes {
  email, password, mobile, name
}