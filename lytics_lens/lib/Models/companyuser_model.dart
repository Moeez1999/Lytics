

import 'dart:convert';

import 'package:get/get.dart';

List<CompanyUsers> companyUsersFromJson(String str) => List<CompanyUsers>.from(json.decode(str).map((x) => CompanyUsers.fromJson(x)));

String companyUsersToJson(List<CompanyUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyUsers {
    CompanyUsers({
        this.id,
        this.firstName,
        this.lastName,
    });

    String? id;
    String? firstName;
    String? lastName;
    var check = false.obs;

    factory CompanyUsers.fromJson(Map<String, dynamic> json) => CompanyUsers(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
    };
}
