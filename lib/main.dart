import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sorted/home_page.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  if (!(Platform.isAndroid || Platform.isIOS || Platform.isFuchsia)) {
    await YaruWindowTitleBar.ensureInitialized();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> snackbarKey =
        GlobalKey<ScaffoldMessengerState>();
    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        debugShowCheckedModeBanner: false,
        home: HomePage(
          snackbarKey: snackbarKey,
        ),
        scaffoldMessengerKey: snackbarKey,
      );
    });
  }
}
