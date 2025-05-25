// lib/navigation_helper.dart
import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/bins');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/routes');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
      default:
        Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }
}