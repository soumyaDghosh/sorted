import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class CustomFilledButton extends StatelessWidget {
  final double fontSize;
  final VoidCallback sort;
  final int width;
  const CustomFilledButton({
    super.key,
    required this.fontSize,
    required this.sort,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        sort();
        // if (selectedAlgorithm == 'Insertion') {
        //   Stopwatch stopwatch = Stopwatch()..start();
        //   Sort insertionSort = Sort(floatNumbers,
        //       optionSelected.contains('reversed'));
        //   setState(() {
        //     result = insertionSort.insertionSort().toString();
        //     time = 'Time taken ${stopwatch.elapsed.toString()}';
        //   });
        //   stopwatch.stop();
        // }
        // if (selectedAlgorithm == 'Bubble') {
        //   Stopwatch stopwatch = Stopwatch()..start();
        //   Sort bubbleSort = Sort(floatNumbers,
        //       optionSelected.contains('reversed'));
        //   setState(() {
        //     result = bubbleSort.bubbleSort().toString();
        //     time = 'Time taken ${stopwatch.elapsed.toString()}';
        //   });
        //   stopwatch.stop();
        // }
        // if (selectedAlgorithm == 'Merge') {
        //   Stopwatch stopwatch = Stopwatch()..start();
        //   Sort mergeSort = Sort(floatNumbers,
        //       optionSelected.contains('reversed'));
        //   setState(() {
        //     result = mergeSort.mergeSort().toString();
        //     time = 'Time taken ${stopwatch.elapsed.toString()}';
        //   });
        //   stopwatch.stop();
        // }
      },
      style: ButtonStyle(
        backgroundColor: isMobile
            ? null
            : MaterialStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
        shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.only(
            top: isMobile ? 5 : 20,
            bottom: isMobile ? 5 : 20,
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
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
