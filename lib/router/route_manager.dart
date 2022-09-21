import 'package:flutter/material.dart';
import 'package:sqlite_demo/models/car.dart';
import 'package:sqlite_demo/screens/car_details_screen.dart';
import 'package:sqlite_demo/screens/edit_car_screen.dart';
import 'package:sqlite_demo/screens/home_screeen.dart';

class RouteNames {
  static const root = "/";
  static const carDetails = "/car-details";
  static const editCar = "/edit-car";
}

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.root:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteNames.carDetails:
        return MaterialPageRoute(
          builder: (_) => CarDetailsScreen(
            car: settings.arguments as Car,
          ),
        );

      case RouteNames.editCar:
        return MaterialPageRoute(
          builder: (_) => EditCarScreen(car: settings.arguments as Car),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => UnKnownRoute(routeName: settings.name ?? ""),
        );
    }
  }
}

class UnKnownRoute extends StatelessWidget {
  const UnKnownRoute({Key? key, required this.routeName}) : super(key: key);

  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('No route defined for $routeName')),
    );
  }
}
