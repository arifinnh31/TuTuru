import 'package:flutter/material.dart';
import 'package:tuturu/presentation/landing_page.dart';
import 'package:tuturu/presentation/login_page.dart';
import 'package:tuturu/presentation/register_page.dart';
import 'package:tuturu/presentation/app_navigation.dart';
import 'package:tuturu/presentation/home_page.dart';
import 'package:tuturu/presentation/profile_page.dart';
import 'package:tuturu/presentation/translate_page.dart';
import 'package:tuturu/presentation/learn_page.dart';

class AppRoutes {
  static const String landingPage = '/';
  static const String loginPage = '/login_page';
  static const String registerPage = '/register_page';
  static const String appNavigation = '/navigation_page';
  static const String homePage = '/home_page';
  static const String profilePage = '/profile_page';
  static const String translatePage = '/translate_page';
  static const String learnPage = '/learn_page';

  static Map<String, WidgetBuilder> routes = {
    landingPage: (context) => LandingPage(),
    loginPage: (context) => LoginPage(),
    registerPage: (context) => RegisterPage(),
    appNavigation: (context) => AppNavigation(),
    homePage: (context) => HomePage(),
    profilePage: (context) => ProfilePage(),
    translatePage: (context) => TranslatePage(cameras: [], isSign: true),
    learnPage: (context) => LearnPage(),
  };
}
