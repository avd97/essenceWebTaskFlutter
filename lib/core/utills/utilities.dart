import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {

  static void showToast(msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static Widget namePlate(label) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white60
      ),
      margin: const EdgeInsets.only(top: 24, left: 12, right: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: Text(label,
          style: const TextStyle(fontSize: 20),),
      ),
    );
  }
}