import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sorted/home_page.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  if (!Platform.isAndroid) {
    await YaruWindowTitleBar.ensureInitialized();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      );
    });
  }
}
