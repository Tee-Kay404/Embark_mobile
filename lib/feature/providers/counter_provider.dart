import 'package:flutter/widgets.dart';

class CounterProvider with ChangeNotifier {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7];
  final List<int> finalNumbers = [1, 2, 3, 4];

// increment method
  void increment() {
    int last = numbers.last;
    numbers.add(last + 1);
    notifyListeners();
  }

// decrement method
  void decrement() {
    numbers.removeLast();
    notifyListeners();
  }

// reset method
  void reset() {
    numbers = finalNumbers;
    notifyListeners();
  }
}
