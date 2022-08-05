import 'package:get/get.dart';

class ProgramNameModel {
  String? id;
  String? name;
  var check = false.obs;

  ProgramNameModel({
    this.id,
    this.name,
  });

  factory ProgramNameModel.fromJSON(Map<String, dynamic> json) => ProgramNameModel(
    id: json['id'],
    name: json['name'],
  );
}
