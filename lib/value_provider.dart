import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StringListProvider extends ChangeNotifier {
  List<String> optionsSelected = [];
  GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  String selectedAlgorithm = 'merge';
  static const options = 'options';
  static const defaultAlgo = 'defaultAlgorithm';

  void getSavedOptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected = prefs.getStringList(options) ?? [];
    selectedAlgorithm = prefs.getString(defaultAlgo) ?? 'merge';
    notifyListeners();
  }

  void addOption(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected.add(string);
    prefs.setStringList(options, optionsSelected);
    notifyListeners();
  }

  void removeOption(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected.remove(string);
    prefs.setStringList(options, optionsSelected);
    notifyListeners();
  }

  void changedefaultAlgo(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAlgorithm = string;
    prefs.setString(defaultAlgo, selectedAlgorithm);
    notifyListeners();
  }

  void reset() async {
    selectedAlgorithm = 'merge';
    optionsSelected = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(options);
    prefs.remove(defaultAlgo);
  }
}
