import 'package:flutter/material.dart';
import 'package:sqlite_demo/helpers/db_helper.dart';

import '../models/car.dart';

class CarsProvider with ChangeNotifier {
  List<Car> _carsList = [];

  List<Car> get carList => [..._carsList];

  Car getCarById(int id) {
    return _carsList.firstWhere((element) => id == element.id);
  }

  Future<void> addCar(Car car) async {
    await DatabaseHelper.instance.insert(car);
    await getAllCars();
    notifyListeners();
  }

  Future<void> updateCar(Car car) async {
    await DatabaseHelper.instance.update(car);
    await getAllCars();
    notifyListeners();
  }

  Future<void> deleteCar(int carId) async {
    await DatabaseHelper.instance.delete(carId);
    await getAllCars();
    notifyListeners();
  }

  Future<void> getAllCars() async {
    final carsMap = await DatabaseHelper.instance.queryAllRows();
    _carsList = carsMap.map((e) {
      return Car.fromMap(e);
    }).toList();
    notifyListeners();
  }
}
