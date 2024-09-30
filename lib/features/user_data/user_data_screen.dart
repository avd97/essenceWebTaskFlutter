import 'package:esenceweb/core/utills/constants.dart';
import 'package:esenceweb/core/utills/utilities.dart';
import 'package:esenceweb/features/authentication/model/login_response.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key, required this.loginResponse});

  final LoginResponse loginResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            width: 120, // Set the width of the container
            height: 120, // Set the height of the container
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Makes the container circular
              border: Border.all(
                color: Colors.black87, // Set the border color
                width: 1.5, // Set the border width
              ),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(Constants.baseURL + loginResponse.user!.photo!,),
            ),
          ),
          Utility.namePlate(loginResponse.user!.fullname!),
          Utility.namePlate(loginResponse.user!.email!),
          Utility.namePlate(loginResponse.user!.mobile!),
        ],
      ),
    );
  }
}
