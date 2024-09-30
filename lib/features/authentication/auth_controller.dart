import 'dart:convert';

import 'package:esenceweb/core/utills/constants.dart';
import 'package:esenceweb/features/authentication/model/login_request.dart';
import 'package:esenceweb/features/authentication/model/login_response.dart';
import 'package:esenceweb/features/authentication/model/registration_response.dart';
import 'package:esenceweb/features/user_data/user_data_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esenceweb/core/utills/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthController with ChangeNotifier {
  BuildContext context;

  bool isObscure = true;
  bool isObscure2 = true;

  var isLoading = false;

  setIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  setIsObscure2() {
    isObscure2 = !isObscure2;
    notifyListeners();
  }

  int? _tabIndex;

  int? get tabIndex => _tabIndex;

  set tabIndex(int? value) {
    _tabIndex = value;
    // notifyListeners();
  }

  String? _fullNameErrMessage;

  String? get fullNameErrMessage => _fullNameErrMessage;

  set fullNameErrMessage(String? value) {
    _fullNameErrMessage = value;
    notifyListeners();
  }

  String? _emailErrMessage;

  String? get emailErrMessage => _emailErrMessage;

  set emailErrMessage(String? value) {
    _emailErrMessage = value;
  }

  String? _mobileErrMessage;

  String? get mobileErrMessage => _mobileErrMessage;

  set mobileErrMessage(String? value) {
    _mobileErrMessage = value;
  }

  String? _passwordErrMessage;

  String? get passwordErrMessage => _passwordErrMessage;

  set passwordErrMessage(String? value) {
    _passwordErrMessage = value;
  }

  String? _passwordErrMessage2;

  String? get passwordErrMessage2 => _passwordErrMessage2;

  set passwordErrMessage2(String? value) {
    _passwordErrMessage2 = value;
  }

  XFile? image;
  AuthController(this.context);

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  LoginResponse loginResponse = LoginResponse();

  final loginFormKey = GlobalKey<FormState>();
  final registrationFormKey = GlobalKey<FormState>();

  void getLogin() async {
    if (loginEmailController.text == "") {
      Utility.showToast('Please enter valid email Id');
    } else if (loginPasswordController.text == "") {
      Utility.showToast('Please enter correct password');
    } else {
      // Constants.showToast('Proceed to Login');
      await loginProcess();
    }
  }

  Future<void> loginProcess() async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse('${Constants.baseURL}api/users/login');
      var headers = {'Content-Type': 'application/json'};

      // Create the login request object
      LoginRequest loginRequest = LoginRequest(
          email: loginEmailController.text.trim(),
          password: loginPasswordController.text.trim());

      // Make the API call
      var response = await http.post(url,
          headers: headers, body: json.encode(loginRequest));

      debugPrint('Login Response: ${response.body}');

      // Parse the response body as JSON before using it
      var jsonResponse = json.decode(response.body); // <- This is important

      // Map the parsed JSON to the LoginResponse model
      loginResponse = LoginResponse.fromJson(jsonResponse);

      debugPrint('Login Response Message: ${loginResponse.message}');
      isLoading = false;
      notifyListeners();
      if (response.statusCode == 200) {
        Constants.showSuccessToast(loginResponse.message);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => UserDataScreen(
              loginResponse: loginResponse,
            ),
          ),
        );
      } else {
        Constants.showFailedToast(loginResponse.message);
      }
    } catch (ex) {
      debugPrint('Exception on Login: $ex');
      Constants.showFailedToast(ex.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registrationProcess() async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse('${Constants.baseURL}api/users/register');

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        'fullname': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'mobile': mobileController.text.trim(),
        'password': passwordController.text.trim()
      });
      request.files
          .add(await http.MultipartFile.fromPath('photo', image!.path));

      http.StreamedResponse response = await request.send();
      var jsonResponse = json.decode(await response.stream.bytesToString());
      RegistrationResponse registrationResponse =
          RegistrationResponse.fromJson(jsonResponse);

      isLoading = false;
      notifyListeners();
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(registrationResponse.message);
        Constants.showSuccessToast(registrationResponse.message);
      } else {
        print(response.reasonPhrase);
        Constants.showFailedToast(registrationResponse.message);
      }
    } catch (ex) {
      debugPrint('SignUp Exe: $ex');
      isLoading = false;
      notifyListeners();
    }
  }

  void registration() async {
    if (emailController.text == "") {
      Utility.showToast('Please enter valid email Id');
    } else if (passwordController.text == "") {
      Utility.showToast('Please enter correct password');
    } else if (confirmPasswordController.text == "" ||
        confirmPasswordController.text != passwordController.text) {
      Utility.showToast('Confirm Password does not matched');
    } else if (image == null) {
      Utility.showToast('Select Profile photo');
    } else {
      // Utility.showToast('Proceed to Registration');
      await registrationProcess();
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    return null;
  }

  String? validateEmail_Id(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid Email format';
    }
    return null;
  }

  String? validateMobileNum(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile Number is required';
    } else if (value.length != 10) {
      return 'Mobile Number must be 10 digits';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password is required';
    }
    return null;
  }

  String? validatePassword2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password does not matched';
    } else if (passwordController.text != confirmPasswordController.text) {
      return 'Password does not matched';
    }
    return null;
  }

  Future<XFile?> selectOrCaptureImage(ImageSource source) async {
    try {
      final ImagePicker _picker = ImagePicker();
      image = await _picker.pickImage(source: source);
    } catch (e) {
      Constants.showFailedToast(e.toString());
    }
    notifyListeners();
    return image;
  }
}
