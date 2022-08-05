import 'package:get/get.dart';

class ReportHostModel {
  String? id;
  String? name;
  var check = false.obs;

  ReportHostModel({
    this.id,
    this.name,
  });

  factory ReportHostModel.fromJSON(Map<String, dynamic> json) => ReportHostModel(
    id: json['id'],
    name: json['name'],
  );
}
