import 'package:get/get.dart';

class HostModel {
  String? id;
  String? name;
  var check = false.obs;

  HostModel({
    this.id,
    this.name,
  });

  factory HostModel.fromJSON(Map<String, dynamic> json) => HostModel(
        id: json['id'],
        name: json['name'],
      );
}
