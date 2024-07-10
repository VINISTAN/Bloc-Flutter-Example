import 'dart:async';

import 'package:bloc_emp/BLoc/Employee_BLoc.dart';

/// Create Employee List

class EmployeeBloc {
  List<Employee> employeeList = [
    Employee(1, "Arun", 10000.0),
    Employee(2, "Balaji", 20000.0),
    Employee(3, "Chandru", 25000.0),
    Employee(4, "Dhinesh", 28000.0),
    Employee(5, "Elango", 15000.0),
  ];

  /// Stream Controllers
  final employeeListStreamController = StreamController<List<Employee>>();
  final employeeSalaryIncrementStreamController = StreamController<Employee>();
  final employeeSalaryDecrementStreamController = StreamController<Employee>();

  ///getter - Stream
  Stream<List<Employee>> get employeeListStream =>
      employeeListStreamController.stream;

  ///getter - Sink
  StreamSink<List<Employee>> get employeeListSink =>
      employeeListStreamController.sink;

  StreamSink<Employee> get EmployeeSalaryIncrementSink =>
      employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get EmployeeSalaryDecrementSink =>
      employeeSalaryDecrementStreamController.sink;

  /// Create a constructor and add data
  EmployeeBloc() {
    employeeListStreamController.add(employeeList);
    employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  /// Core Functionality
  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(employeeList);
  }

  /// Dispose function
  void dispose() {
    employeeListStreamController.close();
    employeeSalaryIncrementStreamController.close();
    employeeSalaryDecrementStreamController.close();
  }
}
