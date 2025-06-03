abstract class Employee {
  void work();
  factory Employee(String type) {
    switch (type) {
      case 'progrmmer':
        return Programmer();
      case 'employee':
        return HREmployer();
      default:
        return Programmer();
    }
  }
}

class Programmer implements Employee {
  @override
  void work() {
    print('coding an app');
  }
}

class HREmployer implements Employee {
  @override
  void work() {
    print('hiring people');
  }
}
