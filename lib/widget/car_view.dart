import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/providers/cars_provider.dart';
import 'package:sqlite_demo/models/car.dart';

class CarView extends StatelessWidget {
  const CarView({Key? key, required this.car}) : super(key: key);

  final Car car;

  void _deleteCar(BuildContext ctx) {
    Provider.of<CarsProvider>(ctx, listen: false).deleteCar(car.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(car.image),
          ),
          title: Text(
            car.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            car.description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Delete Car"),
                  content: Text("Are you sure you want to delete car ?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        _deleteCar(context);
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    )
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade700.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}
