import 'package:get/get.dart';

class GuestModel {
  String? id;
  String? name;
  var check = false.obs;

  GuestModel({
    this.id,
    this.name,
  });

  factory GuestModel.fromJSON(Map<String, dynamic> json) => GuestModel(
        id: json['id'],
        name: json['name'],
      );
}
