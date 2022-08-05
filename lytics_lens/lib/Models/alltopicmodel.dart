import 'package:get/get.dart';

class AllTopicModel {
  String? id;
  String? name;
  var check = false.obs;
  var onTapcheck = false.obs;

  AllTopicModel({
    this.id,
    this.name,
  });

  factory AllTopicModel.fromJSON(Map<String, dynamic> json) => AllTopicModel(
        id: json['id'],
        name: json['name'],
      );
}

