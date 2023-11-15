import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorted/common/widgets/about_section.dart';
import 'package:sorted/common/widgets/header_bar.dart';
import 'package:sorted/common/widgets/snack_bar.dart';
import 'package:sorted/constants.dart';
import 'package:sorted/models/sort_algos.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> snackbarKey;
  const HomePage({super.key, required this.snackbarKey});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode f1 = FocusNode();
  String _popupMenuTitle = 'Select Algorithm';
  String selectedAlgorithm = '';
  String defaultAlgorithm = 'Merge';
  String result = '';
  String time = '';
  List<dynamic> floatNumbers = [];
  List<String> listNumbers = [];
  bool isSnackbar = false;
  bool cleared = false;
  List<String> optionSelected = [];
  static XTypeGroup typeGroup = const XTypeGroup(
    label: 'Documents/Text',
    extensions: ['txt'],
    mimeTypes: ['text/plain', 'text/csv'],
  );

  @override
  void dispose() {
    controller.dispose();
    f1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width.toInt();
    final height = MediaQuery.of(context).size.height.toInt();
    Orientation orientation = MediaQuery.of(context).orientation;
    final double fontSize;
    if (width >= 1100) {
      fontSize = 21;
    } else if (width >= 800 && width < 1100) {
      fontSize = 20;
    } else if (width >= 600 && width < 800) {
      fontSize = 18;
    } else {
      fontSize = 15;
    }

    return YaruDetailPage(
      appBar: const HeaderBar(
        title: Text('Sorted'),
        leading: AboutSection(),
        style: YaruTitleBarStyle.normal,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 20,
                  bottom: 20,
                ),
                child: TextField(
                  focusNode: f1,
                  autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        YaruIconButton(
                          icon: const Icon(YaruIcons.document_new),
                          onPressed: () async {
                            setState(() {});
                            final XFile? file = await openFile(
                                acceptedTypeGroups: [typeGroup],
                                confirmButtonText: 'Select File');

                            file != null
                                ? controller.text = await file.readAsString()
                                : widget.snackbarKey.currentState?.showSnackBar(
                                    snackBar(
                                        'No file selected', fontSize, width,
                                        seconds: 3),
                                  );
                          },
                        ),
                        YaruIconButton(
                          icon: Icon(cleared
                              ? YaruIcons.edit_clear_filled
                              : YaruIcons.edit_clear),
                          tooltip: 'Clear',
                          onPressed: () {
                            widget.snackbarKey.currentState
                                ?.showSnackBar(snackBar(
                                    'Clearing...', fontSize, width,
                                    seconds: 0,
                                    microseconds: 1,
                                    isClosable: false))
                                .closed
                                .then((value) {
                              setState(() {
                                cleared = !cleared;
                              });
                            });
                            setState(() {
                              cleared = !cleared;
                              controller.clear();
                              result = '';
                              time = '';
                              _popupMenuTitle = 'Select Algorithm';
                              floatNumbers = [];
                              time = '';
                            });
                          },
                        ),
                      ],
                    ),
                    hintText: 'Enter the values to sort, separated by commas',
                    filled: true,
                  ),
                ),
              ),
              TextFieldTapRegion(
                child: Column(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var choice in chipOptions)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: width / 100,
                                  right: width / 100,
                                  bottom: optionSelected.contains('manual')
                                      ? 0
                                      : 20,
                                ),
                                child: ChoiceChip(
                                  label: Text(choice),
                                  selected: optionSelected.contains(choice),
                                  onSelected: (value) {
                                    setState(() {
                                      if (value) {
                                        optionSelected.add(choice);
                                      } else {
                                        optionSelected.remove(choice);
                                      }
                                    });
                                    if (choice == 'manual') {
                                      _popupMenuTitle = 'Select Algorithm';
                                      selectedAlgorithm = '';
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (optionSelected.contains('manual'))
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: YaruPopupMenuButton(
                          tooltip: 'Select the Algorithm',
                          enableFeedback: true,
                          child: Text(
                            _popupMenuTitle,
                            style: TextStyle(
                              fontSize: width < 600 ? 13 : fontSize - 8,
                            ),
                          ),
                          itemBuilder: (BuildContext context) {
                            return List.generate(algorithms.length, (index) {
                              return PopupMenuItem<String>(
                                value: algorithms[index],
                                child: Text(
                                  algorithms[index],
                                  style: TextStyle(
                                      fontSize:
                                          width < 600 ? 15 : fontSize - 8),
                                ),
                                onTap: () =>
                                    selectedAlgorithm = algorithms[index],
                              );
                            });
                          },
                          onSelected: (value) {
                            setState(() {
                              _popupMenuTitle = value;
                            });
                          },
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        selectedAlgorithm = optionSelected.contains('manual')
                            ? selectedAlgorithm
                            : defaultAlgorithm;
                        String t1 = controller.text;
                        try {
                          if (t1.isEmpty) {
                            widget.snackbarKey.currentState?.showSnackBar(
                              snackBar(
                                'Dataset is empty!!',
                                fontSize,
                                width,
                              ),
                            );
                            return;
                          }
                          listNumbers =
                              t1.split(',').map((s) => s.trim()).toList();
                          floatNumbers = listNumbers
                              .map((s) => int.tryParse(s) ?? double.parse(s))
                              .toList();
                        } catch (e) {
                          widget.snackbarKey.currentState?.showSnackBar(
                              snackBar(e.toString(), fontSize, width));
                          return;
                        }
                        if (selectedAlgorithm == '') {
                          widget.snackbarKey.currentState?.showSnackBar(
                              snackBar('Select an Algorithm', fontSize, width));
                          return;
                        }
                        if (selectedAlgorithm == 'Insertion') {
                          Stopwatch stopwatch = Stopwatch()..start();
                          Sort insertionSort = Sort(floatNumbers,
                              optionSelected.contains('reversed'));
                          setState(() {
                            result = insertionSort.insertionSort().toString();
                            time = 'Time taken ${stopwatch.elapsed.toString()}';
                          });
                          stopwatch.stop();
                        }
                        if (selectedAlgorithm == 'Bubble') {
                          Stopwatch stopwatch = Stopwatch()..start();
                          Sort bubbleSort = Sort(floatNumbers,
                              optionSelected.contains('reversed'));
                          setState(() {
                            result = bubbleSort.bubbleSort().toString();
                            time = 'Time taken ${stopwatch.elapsed.toString()}';
                          });
                          stopwatch.stop();
                        }
                        if (selectedAlgorithm == 'Merge') {
                          Stopwatch stopwatch = Stopwatch()..start();
                          Sort mergeSort = Sort(floatNumbers,
                              optionSelected.contains('reversed'));
                          setState(() {
                            result = mergeSort.mergeSort().toString();
                            time = 'Time taken ${stopwatch.elapsed.toString()}';
                          });
                          stopwatch.stop();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor,
                        ),
                        shape: const MaterialStatePropertyAll<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            left: width > 1000 ? width / 15 : width / 7,
                            right: width > 1000 ? width / 15 : width / 7,
                          ),
                        ),
                      ),
                      child: Tooltip(
                        message: 'click to sort',
                        child: Text(
                          'Sort',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: (orientation == Orientation.landscape) &&
                                (Platform.isAndroid || Platform.isIOS)
                            ? height - 100
                            : (Platform.isAndroid || Platform.isIOS) &&
                                    (orientation == Orientation.portrait)
                                ? height - 500
                                : width > 800 && height > 1000
                                    ? height - 450
                                    : height - 350,
                        width: width - 50,
                        child: Stack(
                          children: [
                            YaruBanner(
                              child: Column(
                                children: [
                                  Flexible(
                                    child: SingleChildScrollView(
                                      child: SelectableText(
                                        result,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: SelectionArea(
                                      child: SelectableText(
                                        time,
                                        style: TextStyle(
                                          fontSize: fontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10, // Adjust the top position as needed
                              right: 10, // Adjust the right position as needed
                              child: YaruIconButton(
                                tooltip: 'Copy the result',
                                icon: Icon(
                                  isSnackbar
                                      ? YaruIcons.copy_filled
                                      : YaruIcons.copy,
                                  size: fontSize + 5,
                                ),
                                onPressed: () async {
                                  result.isNotEmpty
                                      ? await Clipboard.setData(ClipboardData(
                                          text: result.toString()))
                                      : null;
                                  setState(() {
                                    isSnackbar = !isSnackbar;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          snackBar(
                                            result.isNotEmpty
                                                ? 'Copied to clipboard'
                                                : 'Nothing to copy',
                                            fontSize,
                                            width,
                                          ),
                                        )
                                        .closed
                                        .then((value) {
                                      setState(() {
                                        isSnackbar = !isSnackbar;
                                      });
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
