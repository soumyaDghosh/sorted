import 'package:flutter/material.dart';

const List<String> algorithms = [
  "Insertion",
  "Bubble",
  "Merge",
];

const dataTypes = <String, (Type, bool)>{
  'Number': (int, false),
  'Alphabets': (String, false),
};

const List<String> chipOptions = [
  'reversed',
  'manual',
  'csv',
];

const githubProject = 'https://github.com/soumyaDghosh/sorted';
const githubMe = 'https://github.com/soumyaDghosh';
const githubChintu = 'https://github.com/Chintiw';
const appIcon = 'assets/icon.png';

final errorMessages = [
  'Dataset is empty',
  'Select an Algorithm',
  'No file selected',
];

final contributors = <String, String>{
  'Copyright © Soumyadeep Ghosh 2023 and onwards. All rights reserved.':
      (githubMe),
  'Icon by Chinmay Tiwari': (githubChintu),
};

const bannerBackground = Color.fromRGBO(253, 244, 241, 1);
const bannerBackgorundDark = Color.fromRGBO(71, 62, 59, 1);
