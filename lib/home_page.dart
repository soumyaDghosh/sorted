// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorted/constants.dart';
import 'package:sorted/models/bubble_sort.dart';
import 'package:sorted/models/insertion_sort.dart';
import 'package:sorted/models/merge_sort.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final FocusNode f1 = FocusNode();
  String _popupMenuTitle = 'Select Algorithm';
  String selectedAlgorithm = '';
  String result = '';
  Duration? time;
  List<int> intNumbers = [];
  List<String> listNumbers = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width.toInt();
    final height = MediaQuery.of(context).size.height.toInt();
    final double fontSize;
    if (width >= 1100) {
      fontSize = 24;
    } else if (width >= 800 && width < 1100) {
      fontSize = 22;
    } else if (width >= 600 && width < 800) {
      fontSize = 18;
    } else {
      fontSize = 15;
    }

    return Scaffold(
      appBar: const YaruWindowTitleBar(
        title: Text('Sorted'),
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
                    suffixIcon: YaruIconButton(
                      icon: const Icon(YaruIcons.edit_clear),
                      onPressed: () {
                        setState(() {
                          controller.clear();
                        });
                      },
                    ),
                    hintText: 'Enter the values to sort, separated by commas',
                    filled: true,
                  ),
                ),
              ),
              TextFieldTapRegion(
                onTapOutside: (event) {
                  f1.requestFocus();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: 40,
                      ),
                      child: YaruPopupMenuButton(
                        tooltip: 'Select the Algorithm',
                        enableFeedback: true,
                        child: Text(
                          _popupMenuTitle,
                          style: TextStyle(
                            fontSize: fontSize - 2,
                          ),
                        ),
                        itemBuilder: (BuildContext context) {
                          return List.generate(algorithms.length, (index) {
                            return PopupMenuItem<String>(
                              value: algorithms[index],
                              child: Text(
                                algorithms[index],
                                style: TextStyle(fontSize: fontSize - 2),
                              ),
                              onTap: () =>
                                  selectedAlgorithm = algorithms[index],
                            );
                          });
                        },
                        onSelected: (value) {
                          // Update the selected option and trigger a rebuild
                          setState(() {
                            _popupMenuTitle = value;
                          });
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String t1 = controller.text;
                        try {
                          listNumbers =
                              t1.split(',').map((s) => s.trim()).toList();
                          intNumbers =
                              listNumbers.map((s) => int.parse(s)).toList();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString(),
                                style: TextStyle(fontSize: fontSize),
                              ),
                              behavior: SnackBarBehavior.floating,
                              showCloseIcon: true,
                              width: width - 50,
                            ),
                          );
                        } finally {
                          if (selectedAlgorithm == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Select an Algorithm',
                                  style: TextStyle(fontSize: fontSize),
                                ),
                                showCloseIcon: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              ),
                            );
                          }
                          if (selectedAlgorithm == 'Insertion') {
                            Stopwatch stopwatch = Stopwatch()..start();
                            InsertionSort insertionSort =
                                InsertionSort(intNumbers);
                            setState(() {
                              result = insertionSort.sort().toString();
                              time = stopwatch.elapsed;
                            });
                            stopwatch.stop();
                          }
                          if (selectedAlgorithm == 'Bubble') {
                            Stopwatch stopwatch = Stopwatch()..start();
                            BubbleSort bubbleSort = BubbleSort(intNumbers);
                            setState(() {
                              result = bubbleSort.sort().toString();
                              time = stopwatch.elapsed;
                            });
                            stopwatch.stop();
                          }
                          if (selectedAlgorithm == 'Merge') {
                            Stopwatch stopwatch = Stopwatch()..start();
                            MergeSort mergeSort = MergeSort(intNumbers);
                            setState(() {
                              result = mergeSort.sort().toString();
                              time = stopwatch.elapsed;
                            });
                            stopwatch.stop();
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        shape: const MaterialStatePropertyAll<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: height - 350,
                        width: width - 50,
                        child: Stack(
                          children: [
                            YaruBanner(
                              child: Text(
                                '$result\n\nTime Taken: $time',
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            Positioned(
                              bottom: 10, // Adjust the top position as needed
                              right: 10, // Adjust the right position as needed
                              child: YaruIconButton(
                                icon: Icon(
                                  YaruIcons.copy_filled,
                                  size: fontSize + 5,
                                ),
                                onPressed: () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: result.toString()));
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Copied to clipboard'),
                                        showCloseIcon: true,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                  //_clipboardIcon = const Icon(YaruIcons.copy);
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
