class InsertionSort {
  List<int> numbers;

  InsertionSort(this.numbers);

  List<int> sort() {
    int n = numbers.length;

    for (int i = 1; i < n; i++) {
      int key = numbers[i];
      int j = i - 1;

      // Move elements that are greater than key to one position ahead
      // of their current position
      while (j >= 0 && numbers[j] > key) {
        numbers[j + 1] = numbers[j];
        j = j - 1;
      }
      numbers[j + 1] = key;
    }
    return numbers;
  }
}

void main(List<String> unsortedNumbers) {
  List<int> unSortedNumbers = unsortedNumbers.map((e) => int.parse(e)).toList();

  InsertionSort insertionSort = InsertionSort(unSortedNumbers);

  // Sort the numbers
  insertionSort.sort();
}
