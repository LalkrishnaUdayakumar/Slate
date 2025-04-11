import 'package:flutter/material.dart';
import 'package:slate/src/features/screens/home/slate_home_screen.dart';
import 'package:slate/src/features/screens/slate_style_guide.dart';
import 'package:slate/src/routes/app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.home: (context) => SlateHomeScreen(),
      AppRoutes.styleGuide: (context) => SlateStyleGuide(),
    };
  }
}
