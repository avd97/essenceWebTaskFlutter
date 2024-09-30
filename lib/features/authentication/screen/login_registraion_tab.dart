import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:esenceweb/features/authentication/auth_controller.dart';
import 'package:esenceweb/features/authentication/screen/login_tab.dart';
import 'package:esenceweb/features/authentication/screen/registration_tab.dart';

class LoginRegistrationScreen extends StatelessWidget {
  const LoginRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthController>(
      create: (context) => AuthController(context),
      child: Consumer<AuthController>(
        builder: (context, data, child) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
            ),
            body: DefaultTabController(
              length: 2,
              initialIndex: data.tabIndex ?? 0,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  LoginTab(),
                  RegistrationTab(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
