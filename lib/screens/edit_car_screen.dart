import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_demo/providers/cars_provider.dart';
import 'package:sqlite_demo/models/car.dart';

class EditCarScreen extends StatefulWidget {
  const EditCarScreen({Key? key, required this.car}) : super(key: key);
  final Car car;
  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final imageUrlController = TextEditingController();

  void _onSumbit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    String title = titleController.text;
    String description = descController.text;
    String imageUrl = imageUrlController.text;
    print(title + description + imageUrl);

    await Provider.of<CarsProvider>(context, listen: false).updateCar(
      Car(widget.car.id, title, description, imageUrl),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Car Updated"),
        content: Text("Your car has updated !!!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final car =
        Provider.of<CarsProvider>(context).getCarById(widget.car.id ?? 0);
    titleController.text = car.name;
    descController.text = car.description;
    imageUrlController.text = car.image;

    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
                controller: titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter valid title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                ),
                controller: descController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter valid Description";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: imageUrlController.text.trim().isNotEmpty
                        ? NetworkImage(imageUrlController.text.trim())
                        : null,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "ImageUrl",
                      ),
                      controller: imageUrlController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter valid Image Url";
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: _onSumbit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Text("Update Car"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
