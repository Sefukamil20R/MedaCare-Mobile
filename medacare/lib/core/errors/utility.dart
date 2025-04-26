import 'dart:ui';

import 'package:flutter/material.dart';

class ErrorMapper {
  static String getFriendlyMessage(String error) {
    if (error.contains('Password must contain')) {
      return 'Your password must contain at least 8 characters, including an uppercase letter, a lowercase letter, and a special character.';
    } else if (error.contains('User is already verified')) {
      return 'Your email is already verified. Please log in.';
    } else if (error.contains('Verification failed')) {
      return 'The verification code is invalid or expired. Please try again.';
    } else if (error.contains('Failed to resend verification email')) {
      return 'Unable to resend the verification email. Please try again later.';
    } else if (error.contains('Registration failed')) {
      return 'Registration failed. Please check your details and try again.';
    } else if (error.contains('Login failed')) {
      return 'Invalid email or password. Please try again.';
    } else if (error.contains('Failed to fetch profile')) {
      return 'Unable to fetch your profile. Please try again later.';
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}
void showCustomSnackBar(BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
class ValidationService {
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
  bool isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$');
    return passwordRegex.hasMatch(password);
  }
}