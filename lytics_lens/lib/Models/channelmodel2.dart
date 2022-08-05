import 'package:get/get.dart';

class ChannelModel2 {
  String? id;
  String? name;
  var check = false.obs;

  ChannelModel2({
    this.id,
    this.name,
  });

  factory ChannelModel2.fromJSON(Map<String, dynamic> json) => ChannelModel2(
    id: json['id'],
    name: json['name'],
  );
}
