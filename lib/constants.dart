import 'package:flutter/material.dart';

const List<String> algorithms = [
  "insertion",
  "bubble",
  "merge",
];

const dataTypes = <String, (Type, bool)>{
  'Number': (int, false),
  'Alphabets': (String, false),
};

const Map<String, (String, String)> chipOptions = {
  'reversed': ('Reversed', 'Reverse the result'),
  // 'csv': ('CSV', 'Use CSV files'),
  'manual': ('Manual', 'Select Manual Algorithm\nDefault is Merge'),
};

const githubProject = 'https://github.com/soumyaDghosh/sorted';
const githubMe = 'https://github.com/soumyaDghosh';
const githubChintu = 'https://github.com/Chintiw';
const appIcon = 'assets/icon.png';
const toolTips = [
  'Select the Algorithm',
];

const settingsHeaders = [
  'Algorithm',
  'General',
];

const errorMessages = [
  'Dataset is empty',
  'Select an Algorithm',
  'No file selected',
];

const contributors = <String, String>{
  'Copyright © Soumyadeep Ghosh 2023 and onwards. All rights reserved.':
      (githubMe),
  'Icon by Chinmay Tiwari': (githubChintu),
};

const bannerBackground = Color.fromRGBO(253, 244, 241, 1);
const bannerBackgorundDark = Color.fromRGBO(71, 62, 59, 1);

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
