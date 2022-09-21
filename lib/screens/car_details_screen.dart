import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/providers/cars_provider.dart';
import 'package:sqlite_demo/models/car.dart';
import 'package:sqlite_demo/router/route_manager.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({Key? key, required this.car}) : super(key: key);

  final Car car;

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final car =
        Provider.of<CarsProvider>(context).getCarById(widget.car.id ?? 0);
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouteNames.editCar, arguments: widget.car);
            },
            icon: Icon(Icons.edit),
            tooltip: "Edit Details",
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(car.image),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  car.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  car.description,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
