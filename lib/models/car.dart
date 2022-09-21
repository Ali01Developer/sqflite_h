import 'package:sqlite_demo/helpers/db_helper.dart';

class Car {
  int? id;
  String name;
  String description;
  String image;

  Car(this.id, this.name, this.description, this.image);

  factory Car.fromMap(Map<String, dynamic> map) {
    var id = map['id'] ?? 0;
    var name = map['name'] ?? "";
    var description = map['description'] ?? "";
    var image = map['image'] ?? "";

    return Car(id, name, description, image);
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnDescription: description,
      DatabaseHelper.columnImage: image,
    };
  }
}
