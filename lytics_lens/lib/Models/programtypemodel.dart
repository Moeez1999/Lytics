import 'package:get/get.dart';

class ProgramTypeModel {
  String? id;
  String? name;
  var check = false.obs;

  ProgramTypeModel({
    this.id,
    this.name,
  });

  factory ProgramTypeModel.fromJSON(Map<String, dynamic> json) => ProgramTypeModel(
    id: json['id'],
    name: json['name'],
  );
}
