// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<Subscription> subscriptionFromJson(String str) => List<Subscription>.from(
    json.decode(str).map((x) => Subscription.fromJson(x)));

String subscriptionToJson(List<Subscription> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscription {
  Subscription({
    this.source,
    this.sourceValue,
  });

  String? source;
  List<SourceValue>? sourceValue;
  var check = false.obs;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        source: json["source"],
        sourceValue: List<SourceValue>.from(
            json["source_value"].map((x) => SourceValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "source_value": List<dynamic>.from(sourceValue!.map((x) => x.toJson())),
      };
}

class SourceValue {
  SourceValue({
    this.sValues,
  });

  String? sValues;
  var check1 = false.obs;

  factory SourceValue.fromJson(Map<String, dynamic> json) => SourceValue(
        sValues: json["sValues"],
      );

  Map<String, dynamic> toJson() => {
        "sValues": sValues,
      };
}
