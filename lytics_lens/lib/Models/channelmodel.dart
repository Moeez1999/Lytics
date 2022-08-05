import 'package:get/get.dart';

class ChannelModel {
  String? id;
  String? name;
  var check = true.obs;

  ChannelModel({
    this.id,
    this.name,
  });

  factory ChannelModel.fromJSON(Map<String, dynamic> json) => ChannelModel(
        id: json['id'],
        name: json['name'],
      );
}
