// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  Usermodel({
    this.role,
    this.tagNo,
    this.organizationalUnit,
    this.rules,
    this.channels,
    this.status,
    this.active,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.id,
  });

  String? role;
  String? tagNo;
  String? organizationalUnit;
  dynamic rules;
  List<String>? channels;
  String? status;
  String? active;
  String? firstName;
  String? lastName;
  String? email;
  String? userName;
  String? id;

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
    role: json["role"],
    tagNo: json["tagNo"],
    organizationalUnit: json["organizationalUnit"],
    rules: json["rules"],
    channels: List<String>.from(json["channels"].map((x) => x)),
    status: json["status"],
    active: json["active"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    userName: json["userName"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "tagNo": tagNo,
    "organizationalUnit": organizationalUnit,
    "rules": rules,
    "channels": List<dynamic>.from(channels!.map((x) => x)),
    "status": status,
    "active": active,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "userName": userName,
    "id": id,
  };
}
