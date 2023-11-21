import 'package:flutter/material.dart';
import 'package:sorted/homepage/home_page.dart';
import 'package:sorted/settings_menu/settings_menu.dart';

const String homePage = 'homepage';
const String settingsPage = 'settingspage';
Route<dynamic> routecontroller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      throw ('No such page!');
  }
}
