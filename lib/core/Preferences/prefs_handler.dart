import 'dart:developer';
import 'dart:io';

import 'package:doct_plant/core/utils/approuter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefasHandelr {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    prefs = await SharedPreferences.getInstance();
  }

  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<String?> getUserProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image');
  }

  static Future<void> saveUserProfileImage(String profileImage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', profileImage);
  }

  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> printAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      log('Stored Token: $token');
    } else {
      log('No token found in SharedPreferences.');
    }
  }

  static Future<void> checkAuthToken(context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      GoRouter.of(context).go(AppRouter.kDrHub);
    } else {
      // Token is null, navigate to login screen (optional)
      GoRouter.of(context).go(AppRouter.kHomeView);
    }
  }

  static Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .remove('auth_token'); // Removes the token from SharedPreferences
    log('Auth token cleared successfully.');
  }
}
