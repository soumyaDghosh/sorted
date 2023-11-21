import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StringListProvider extends ChangeNotifier {
  List<String> optionsSelected = [];
  GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  String selectedAlgorithm = 'Merge';

  void getSavedOptions() async {
    print('Getting...');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected = prefs.getStringList('options') ?? [];
    selectedAlgorithm = prefs.getString('defaultAlgo') ?? 'Merge';
    notifyListeners();
  }

  void addOption(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected.add(string);
    prefs.setStringList('options', optionsSelected);
    notifyListeners();
  }

  void removeOption(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    optionsSelected.remove(string);
    prefs.setStringList('options', optionsSelected);
    notifyListeners();
  }

  void changedefaultAlgo(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAlgorithm = string;
    prefs.setString('defaultAlgorithm', selectedAlgorithm);
    notifyListeners();
  }
}
