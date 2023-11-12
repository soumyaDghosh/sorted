class MergeSort {
  List<dynamic> numbers;

  MergeSort(this.numbers);

  List<dynamic> sort() {
    _mergeSort(0, numbers.length - 1);
    return numbers;
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
}
