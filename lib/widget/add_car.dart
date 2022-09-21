import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cars_provider.dart';
import '../models/car.dart';

class NewCarAdd extends StatefulWidget {
  const NewCarAdd({Key? key}) : super(key: key);

  @override
  State<NewCarAdd> createState() => _NewCarAddState();
}

class _NewCarAddState extends State<NewCarAdd> {
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

    await Provider.of<CarsProvider>(context, listen: false).addCar(
      Car(null, title, description, imageUrl),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: (MediaQuery.of(context).viewInsets.bottom + 40),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add New Car",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                      onChanged: (value) {
                        setState(() {});
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
                  child: Text("Add Car"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
