import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:esenceweb/core/utills/constants.dart';
import 'package:esenceweb/features/authentication/auth_controller.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  @override
  Widget build(BuildContext context) {
    var height = const SizedBox(
      height: 20,
    );

    return Consumer<AuthController>(builder: (context, data, child) {
      return Form(
        key: data.loginFormKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height,
                const Icon(
                  Icons.domain_verification_rounded,
                  size: 50,
                ),
                height,
                const Text(
                  'Welcome back cheif!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                height,
                TextFormField(
                  controller: data.loginEmailController,
                  decoration: InputDecoration(
                    labelText: '* Email Id',
                    errorText: data.emailErrMessage,
                    enabledBorder: Constants.enabledBorder(),
                    focusedBorder: Constants.focusedBorder(),
                    errorBorder: Constants.errorBorder(),
                    border: Constants.textFieldBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(255),
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  validator: (value) {
                    return data.validateEmail_Id(value);
                  },
                  onChanged: (value) {},
                ),
                height,
                TextFormField(
                  controller: data.loginPasswordController,
                  obscureText: data.isObscure,
                  decoration: InputDecoration(
                    labelText: '* Password',
                    errorText: data.passwordErrMessage,
                    enabledBorder: Constants.enabledBorder(),
                    focusedBorder: Constants.focusedBorder(),
                    errorBorder: Constants.errorBorder(),
                    border: Constants.textFieldBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        data.isObscure
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                      onPressed: () {
                        data.setIsObscure();
                      },
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  validator: (value) {
                    return data.validatePassword(value);
                  },
                  onChanged: (value) {},
                ),
                height,
                Visibility(
                  visible: !data.isLoading,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (data.loginFormKey.currentState!.validate()) {
                        data.getLogin();
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                ),
                height,
                InkWell(
                  onTap: () {
                    if (!data.isLoading) {
                      data.tabIndex = 1;
                      DefaultTabController.of(context)
                          .animateTo(data.tabIndex!);
                    }
                  },
                  child: const Text(
                    'Don\'t have an account? Create one...!',
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
