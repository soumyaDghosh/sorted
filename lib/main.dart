import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorted/value_provider.dart';
import 'package:sorted/route.dart';
import 'package:sorted/theme.dart';
import 'package:yaru_widgets/yaru_widgets.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  if (!(Platform.isAndroid || Platform.isIOS || Platform.isFuchsia)) {
    await YaruWindowTitleBar.ensureInitialized();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StringListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final snackbarKey = context.watch<StringListProvider>().snackbarKey;

    final yaruTheme = YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        initialRoute: homePage,
        onGenerateRoute: routecontroller,
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: snackbarKey,
      );
    });
    final androidTheme = DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        initialRoute: homePage,
        onGenerateRoute: routecontroller,
        theme: m3Theme(
          color: lightDynamic?.primary.withOpacity(1) ?? Colors.deepOrange,
          scaffoldBackgroundColor: lightDynamic?.background,
          foregroundColor: lightDynamic?.primary,
        ),
        darkTheme: m3Theme(
          brightness: Brightness.dark,
          color: darkDynamic?.primary.withOpacity(1) ?? Colors.orange,
          scaffoldBackgroundColor: darkDynamic?.background,
          foregroundColor: darkDynamic?.primary ?? Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: snackbarKey,
      );
    });
    return isMobile ? androidTheme : yaruTheme;
  }
}
