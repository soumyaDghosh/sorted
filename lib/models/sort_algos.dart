import 'package:flutter/material.dart';
import 'package:sorted/constants.dart';

class Sort {
  List<dynamic> numbers;
  bool reversed;
  final GlobalKey<ScaffoldMessengerState> snackbarKey;
  final double fontSize;
  final int width;

  Sort(
    this.numbers,
    this.reversed,
    this.snackbarKey,
    this.fontSize,
    this.width,
  );

  String bubbleSort() {
    int n = numbers.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (numbers[j] > numbers[j + 1]) {
          // Swap numbers[j] and numbers[j+1]
          dynamic temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
        }
      }
    }
    return reversed ? numbers.reversed.toList().toString() : numbers.toString();
  }

  String mergeSort() {
    _mergeSort(0, numbers.length - 1);
    return reversed ? numbers.reversed.toList().toString() : numbers.toString();
  }

  void _mergeSort(int low, int high) {
    if (low < high) {
      int mid = (low + high) ~/ 2;

      // Sort the first and second halves
      _mergeSort(low, mid);
      _mergeSort(mid + 1, high);

      // Merge the sorted halves
      _merge(low, mid, high);
    }
  }

  void _merge(int low, int mid, int high) {
    int n1 = mid - low + 1;
    int n2 = high - mid;

    List<dynamic> left = List<dynamic>.filled(n1, 0);
    List<dynamic> right = List<dynamic>.filled(n2, 0);

    // Copy data to temporary arrays left[] and right[]
    for (int i = 0; i < n1; i++) {
      left[i] = numbers[low + i];
    }
    for (int j = 0; j < n2; j++) {
      right[j] = numbers[mid + 1 + j];
    }

    // Merge the temporary arrays back into numbers[low..high]
    int i = 0, j = 0, k = low;

    while (i < n1 && j < n2) {
      if (left[i] <= right[j]) {
        numbers[k] = left[i];
        i++;
      } else {
        numbers[k] = right[j];
        j++;
      }
      k++;
    }

    // Copy the remaining elements of left[], if there are any
    while (i < n1) {
      numbers[k] = left[i];
      i++;
      k++;
    }

    // Copy the remaining elements of right[], if there are any
    while (j < n2) {
      numbers[k] = right[j];
      j++;
      k++;
    }
  }

  String insertionSort() {
    int n = numbers.length;

    for (int i = 1; i < n; i++) {
      dynamic key = numbers[i];
      int j = i - 1;

      // Move elements that are greater than key to one position ahead
      // of their current position
      while (j >= 0 && numbers[j] > key) {
        numbers[j + 1] = numbers[j];
        j = j - 1;
      }
      numbers[j + 1] = key;
    }
    return reversed ? numbers.reversed.join(',') : numbers.toString();
  }

  dynamic getMethod(String algorithm) {
    switch (algorithm) {
      case 'Bubble':
        return bubbleSort();
      case 'Insertion':
        return insertionSort();
      case 'Merge':
        return mergeSort();
      case '':
        throw ErrorDescription(errorMessages[1]);
      default:
        return mergeSort();
    }
  }
}
