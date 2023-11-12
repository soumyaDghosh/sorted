// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sorted/constants.dart';
import 'package:sorted/models/bubble_sort.dart';
import 'package:sorted/models/insertion_sort.dart';
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
    return Scaffold(
      appBar: const YaruWindowTitleBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20 * 2),
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
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
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
                    padding: const EdgeInsets.all(20),
                    child: YaruPopupMenuButton(
                      tooltip: 'Select the Algorithm',
                      enableFeedback: true,
                      child: Text(_popupMenuTitle),
                      itemBuilder: (BuildContext context) {
                        return List.generate(algorithms.length, (index) {
                          return PopupMenuItem<String>(
                            value: algorithms[index],
                            child: Text(algorithms[index]),
                            onTap: () => selectedAlgorithm = algorithms[index],
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
                            ),
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                          ),
                        );
                      }
                      if (selectedAlgorithm == 'Insertion') {
                        Stopwatch stopwatch = Stopwatch()..start();
                        InsertionSort insertionSort = InsertionSort(intNumbers);
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
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        shape: const MaterialStatePropertyAll<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        )),
                    child: const Text(
                      'Calculate',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 225,
                      width: 400,
                      child: YaruBanner(
                        child: Text('$result\n\nTime Taken: $time'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
