import 'package:get/get.dart';

class DatesModel1 {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  var check = false.obs;

  DatesModel1({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
  });

  factory DatesModel1.fromJSON(Map<String, dynamic> json) => DatesModel1(
    id: json['id'],
    name: json['name'],
    startDate: json['startDate'],
    endDate: json['endDate'],
  );
}
