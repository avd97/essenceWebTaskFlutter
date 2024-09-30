import 'dart:io';

import 'package:esenceweb/core/utills/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:esenceweb/features/authentication/auth_controller.dart';

class RegistrationTab extends StatelessWidget {
  const RegistrationTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = const SizedBox(
      height: 20,
    );
    return Consumer<AuthController>(builder: (context, data, child) {
      return Form(
        key: data.registrationFormKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              ListView(
                children: [
                  height,
                  const Icon(
                    Icons.domain_verification_rounded,
                    size: 50,
                  ),
                  height,
                  const Text('Signup and Enjoy.'),
                  height,
                  Center(
                    child: InkWell(
                      onTap: () {
                        showMenu(
                            context: context,
                            position:
                                const RelativeRect.fromLTRB(200, 250, 0, 0),
                            items: [
                              PopupMenuItem(
                                value: 'capture',
                                child: const Text('Capture a Photo'),
                                onTap: () {
                                  data.selectOrCaptureImage(ImageSource.camera);
                                },
                              ),
                              PopupMenuItem(
                                value: 'gallery',
                                child: const Text('Pick from Gallery'),
                                onTap: () {
                                  data.selectOrCaptureImage(
                                      ImageSource.gallery);
                                },
                              ),
                            ]);
                      },
                      child: CircleAvatar(
                        radius: 60,
                        child: data.image == null
                            ? SvgPicture.string(
                                Constants.userTieSVG,
                                semanticsLabel: 'Acme Logo',
                                width: 70,
                                height: 70,
                              )
                            : Container(
                                width: 120, // Set the width of the container
                                height: 120, // Set the height of the container
                                decoration: BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Makes the container circular
                                  border: Border.all(
                                    color:
                                        Colors.black87, // Set the border color
                                    width: 1.5, // Set the border width
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.file(
                                    File(data.image!.path),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  height,
                  TextFormField(
                    controller: data.fullNameController,
                    decoration: InputDecoration(
                      labelText: '* Full Name',
                      errorText: data.fullNameErrMessage,
                      enabledBorder: Constants.enabledBorder(),
                      focusedBorder: Constants.focusedBorder(),
                      errorBorder: Constants.errorBorder(),
                      border: Constants.textFieldBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    validator: (value) {
                      return data.validateName(value);
                    },
                    onChanged: (value) {},
                  ),
                  height,
                  TextFormField(
                    controller: data.emailController,
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
                    controller: data.mobileController,
                    decoration: InputDecoration(
                      labelText: '* Mobile No.',
                      errorText: data.mobileErrMessage,
                      enabledBorder: Constants.enabledBorder(),
                      focusedBorder: Constants.focusedBorder(),
                      errorBorder: Constants.errorBorder(),
                      border: Constants.textFieldBorder(),
                      prefixText: "+91-",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      return data.validateMobileNum(value);
                    },
                    onChanged: (value) {},
                  ),
                  height,
                  TextFormField(
                    controller: data.passwordController,
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
                  TextFormField(
                    controller: data.confirmPasswordController,
                    obscureText: data.isObscure2,
                    decoration: InputDecoration(
                      labelText: '*Confirm Password',
                      errorText: data.passwordErrMessage2,
                      enabledBorder: Constants.enabledBorder(),
                      focusedBorder: Constants.focusedBorder(),
                      errorBorder: Constants.errorBorder(),
                      border: Constants.textFieldBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          data.isObscure2
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                        onPressed: () {
                          data.setIsObscure2();
                        },
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    validator: (value) {
                      return data.validatePassword2(value);
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
                        if (data.registrationFormKey.currentState!.validate()) {
                          data.registration();
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  height,
                  InkWell(
                    onTap: () {
                      if (!data.isLoading) {
                        data.tabIndex = 0;
                        DefaultTabController.of(context)
                            .animateTo(data.tabIndex!);
                      }
                    },
                    child: const Text(
                      'Already have an account? Go... Sign In!',
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
              // Visibility(
              //   visible: !data.isLoading,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //     decoration: BoxDecoration(
              //       color: Colors.black54
              //     ),
              //     child: Center(
              //       child: CircularProgressIndicator(
              //         color: Colors.yellow,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      );
    });
  }
}
