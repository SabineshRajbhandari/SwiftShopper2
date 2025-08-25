import 'package:flutter/material.dart';

/// Application-wide string constants
class AppStrings {
  static const appName = "SwiftShopper";
  static const welcomeMessage = "Welcome to SwiftShopper!";
  static const errorMessage = "Something went wrong, please try again.";
  static const loginFailed = "Login failed. Please check credentials.";
  static const emailHint = "Enter your email";
  static const passwordHint = "Enter your password";
}

/// URLs and API endpoints
class ApiConstants {
  static const baseUrl = "https://api.swiftshopper.com/v1/";
  static const loginEndpoint = "auth/login";
  static const signupEndpoint = "auth/signup";
  static const productsEndpoint = "products";
}

/// Shared preferences keys
class PrefKeys {
  static const userToken = "user_token";
  static const userEmail = "user_email";
}

/// Common colors used throughout the app
class AppColors {
  static const primaryColor = Color(0xFF0A73FF);
  static const accentColor = Color(0xFFFFA726);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const errorColor = Color(0xFFD32F2F);
  static const textColorPrimary = Color(0xFF212121);
  static const textColorSecondary = Color(0xFF757575);
}

/// Common font sizes used throughout the app
class FontSizes {
  static const large = 24.0;
  static const medium = 18.0;
  static const small = 14.0;
}

/// Duration constants for animations, timeouts, etc.
class Durations {
  static const animationDuration = Duration(milliseconds: 300);
  static const splashScreenDuration = Duration(seconds: 2);
}

/// Input field related constants
class InputFieldConstants {
  static const minPasswordLength = 6;
}
