

import 'dart:convert';

import 'package:get/get.dart';

List<TopicModel> topicModelFromJson(String str) => List<TopicModel>.from(json.decode(str).map((x) => TopicModel.fromJson(x)));

String topicModelToJson(List<TopicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopicModel {
    TopicModel({
        this.description,
        this.name,
        this.color,
        this.topic2,
        this.id,
    });

    String? description;
    String? name;
    String? color;
    List<Topic2>? topic2;
    String? id;
    var topicCheck = false.obs;

    factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
        description: json["description"],
        name: json["name"],
        color: json["color"],
        topic2: List<Topic2>.from(json["topic2"].map((x) => Topic2.fromJson(x))),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "name": name,
        "color": color,
        "topic2": List<dynamic>.from(topic2!.map((x) => x.toJson())),
        "id": id,
    };
}

class Topic2 {
    Topic2({
        this.id,
        this.name,
        this.topic3,
    });

    String? id;
    String? name;
    List<Topic3>? topic3;
    var topicCheck2 = false.obs;


    factory Topic2.fromJson(Map<String, dynamic> json) => Topic2(
        id: json["_id"],
        name: json["name"],
        topic3: List<Topic3>.from(json["topic3"].map((x) => Topic3.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "topic3": List<dynamic>.from(topic3!.map((x) => x.toJson())),
    };
}

class Topic3 {
    Topic3({
        this.id,
        this.name,
    });

    String? id;
    String? name;
    var topicCheck3 = false.obs;

    factory Topic3.fromJson(Map<String, dynamic> json) => Topic3(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
