import 'package:get/get.dart';

class ProgramTypeModel1 {
  String? id;
  String? name;
  var check = false.obs;

  ProgramTypeModel1({
    this.id,
    this.name,
  });

  factory ProgramTypeModel1.fromJSON(Map<String, dynamic> json) => ProgramTypeModel1(
    id: json['id'],
    name: json['name'],
  );
}
