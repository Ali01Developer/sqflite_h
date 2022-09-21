import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/providers/cars_provider.dart';
import 'package:sqlite_demo/router/route_manager.dart';

import '../models/car.dart';
import '../widget/add_car.dart';
import '../widget/car_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getCars();
  }

  void _getCars() async {
    await Provider.of<CarsProvider>(context, listen: false).getAllCars();
  }

  @override
  Widget build(BuildContext context) {
    final _carsProvider = Provider.of<CarsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cars"),
        actions: [
          IconButton(
            onPressed: () => _shoeBottomSheet(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _carsProvider.carList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: CarView(
              car: _carsProvider.carList[index],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteNames.carDetails,
                arguments: _carsProvider.carList[index],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _shoeBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _shoeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bCtx) {
        return NewCarAdd();
      },
    );
  }
}
