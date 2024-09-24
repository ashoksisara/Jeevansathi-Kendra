import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/signin_state.dart';
import 'package:flutter/material.dart';

import '../../../screens/core.dart';
import 'signin_middleware.dart';

SignInState? sign_in_reducer(SignInState? state, dynamic action) {
  if (action is SignInAction) {
    return loader(state, action);
  }
  if (action is IsPhoneOrEmailChangeAction) {
    state!.isPhone = !state.isPhone!;
    return state;
  }
  if (action is SetPhoneNumberAction) {
    state!.phoneNumber = action.payload;
    return state;
  }
  if (action is IsObscureAction) {
    state!.isObscure = !state.isObscure!;
    return state;
  }
  if (action is LoginRequest) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!requiredFieldVerification(state!)) {
      return state;
    }
    bool isOtp = store.state.addonState!.data?.otpSystem ?? false;

    var emailOrPhone = isOtp
        ? state.isPhone!
            ? state.phoneNumber
            : state.emailPhoneController!.text
        : state.emailPhoneController!.text;

    state.passwordErrorText = '';
    state.emailErrorText = '';
    store.dispatch(
      signInMiddleware(
        OneContext().context!,
        email: emailOrPhone,
        password: state.passwordController!.text,
      ),
    );
    return state;
  }

  if (action is ClearAction) {
    state!.passwordErrorText = '';
    state.emailErrorText = '';
  }

  return state;
}

bool requiredFieldVerification(SignInState state) {
  if (state.emailPhoneController!.text.isEmpty) {
    state.emailErrorText = "Please enter email address or phone number";
    return false;
  } else if (!isValidEmail(state.emailPhoneController!.text) && !isValidPhone(state.emailPhoneController!.text)) {
    state.emailErrorText = "Please enter a valid email address";
    return false;
  } else if (state.passwordController!.text.isEmpty) {
    state.passwordErrorText = "Please enter password";
    return false;
  } else if (state.passwordController!.text.length <= 7) {
    state.passwordErrorText = "Password should be 8 Characters long";
    return false;
  }

  return true;
}

bool isValidEmail(String email) {
  String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(emailPattern);
  return regex.hasMatch(email);
}


bool isValidPhone(String phone) {
  String phonePattern = r'^\d{10}$';
  RegExp regex = RegExp(phonePattern);
  return regex.hasMatch(phone);
}

class IsPhoneOrEmailChangeAction {}

class LoginRequest {
  bool isEmail = true;
  LoginRequest({required this.isEmail});
}

class ClearAction {}

loader(SignInState? state, SignInAction action) {
  if (action.from == "custom") {
    state!.isCustomLogin = !state.isCustomLogin!;
  } else {
    state!.isLogin = !state.isLogin!;
  }
  return state;
}
