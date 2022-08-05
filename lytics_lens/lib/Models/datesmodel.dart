import 'package:get/get.dart';

class DatesModel {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  var check = false.obs;

  DatesModel({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
  });

  factory DatesModel.fromJSON(Map<String, dynamic> json) => DatesModel(
    id: json['id'],
    name: json['name'],
    startDate: json['startDate'],
    endDate: json['endDate'],
  );
}
