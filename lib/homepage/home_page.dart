import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorted/common/widgets/header_bar.dart';
import 'package:sorted/common/widgets/snack_bar.dart';
import 'package:sorted/constants.dart';
import 'package:sorted/homepage/action_menu.dart';
import 'package:sorted/homepage/banner.dart';
import 'package:sorted/homepage/filled_button.dart';
import 'package:sorted/homepage/text_field_bar.dart';
import 'package:sorted/calculate/sort_algos.dart';
import 'package:sorted/value_provider.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode f1 = FocusNode();
  String result = '';
  String time = '';
  List<dynamic> floatNumbers = [];
  List<String> listNumbers = [];
  bool isSnackbar = false;
  bool cleared = false;
  static XTypeGroup typeGroup = const XTypeGroup(
    label: 'Documents/Text',
    extensions: ['txt'],
    mimeTypes: ['text/plain', 'text/csv'],
  );

  @override
  void initState() {
    context.read<StringListProvider>().getSavedOptions();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    f1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snackbarKey = context.watch<StringListProvider>().snackbarKey;
    final List<String> optionSelected =
        context.read<StringListProvider>().optionsSelected;
    final String selectedAlgorithm =
        context.read<StringListProvider>().selectedAlgorithm;
    final bool lightTheme = Theme.of(context).brightness == Brightness.light;
    final width = MediaQuery.of(context).size.width.toInt();
    final height = MediaQuery.of(context).size.height.toInt();
    Orientation orientation = MediaQuery.of(context).orientation;
    final double fontSize;
    if (width >= 1100) {
      fontSize = 20.5;
    } else if (width >= 800 && width < 1100) {
      fontSize = 20;
    } else if (width >= 600 && width < 800) {
      fontSize = 18;
    } else {
      fontSize = 15;
    }

    void clearValues() {
      setState(() {
        result = '';
        time = '';
        floatNumbers = [];
      });
    }

    void sort() {
      String t1 = controller.text.trim();
      try {
        if (t1.isEmpty) {
          snackbarKey.currentState?.hideCurrentSnackBar();
          snackbarKey.currentState?.showSnackBar(
            snackBar(
              errorMessages[0],
              fontSize,
              width,
              snackbarKey,
              seconds: 5,
            ),
          );
          return;
        }
        listNumbers = t1.split(',').map((s) => s.trim()).toList();
        floatNumbers =
            listNumbers.map((s) => int.tryParse(s) ?? double.parse(s)).toList();
      } catch (e) {
        snackbarKey.currentState?.hideCurrentSnackBar();
        snackbarKey.currentState?.showSnackBar(
            snackBar(e.toString(), fontSize, width, snackbarKey));
        return;
      }
      Stopwatch stopwatch = Stopwatch()..start();
      Sort sort = Sort(
        floatNumbers,
        optionSelected.contains('reversed'),
        snackbarKey,
        fontSize,
        width,
      );
      setState(() {
        try {
          result = sort.getMethod(selectedAlgorithm);
          time = stopwatch.elapsed.toString();
          snackbarKey.currentState?.showSnackBar(snackBar(
            'Done in $time',
            fontSize,
            width,
            snackbarKey,
            seconds: 5,
          ));
        } catch (e) {
          snackbarKey.currentState?.hideCurrentSnackBar();
          snackbarKey.currentState?.showSnackBar(
              snackBar(e.toString(), fontSize, width, snackbarKey));
        }
      });
      stopwatch.stop();
    }

    final column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
            top: 20,
            bottom: 20,
          ),
          child: TextFieldBar(
            f1: f1,
            controller: controller,
            snackbarKey: snackbarKey,
            fontSize: fontSize,
            width: width,
            typeGroup: typeGroup,
            clearValues: clearValues,
          ),
        ),
        CustomFilledButton(fontSize: fontSize, sort: sort, width: width),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: (orientation == Orientation.landscape) &&
                    (Platform.isAndroid || Platform.isIOS)
                ? height - 50
                : (Platform.isAndroid || Platform.isIOS) &&
                        (orientation == Orientation.portrait)
                    ? height - 300
                    : width > 800 && height > 1000
                        ? height - 450
                        : height - 350,
            width: width - 50,
            child: BannerWithStack(
              lightTheme: lightTheme,
              result: result,
              snackbarKey: snackbarKey,
              fontSize: fontSize,
              width: width,
            ),
          ),
        ),
      ],
    );

    final headerBar = HeaderBar(
      title: const Text('Sorted'),
      actions: isMobile ? const [ActionMenu()] : null,
      leading: const ActionMenu(),
      style: YaruTitleBarStyle.normal,
    );
    return isMobile
        ? Scaffold(
            appBar: headerBar,
            body: SingleChildScrollView(
              child: column,
            ),
          )
        : YaruDetailPage(
            appBar: headerBar,
            body: column,
          );
  }
}
