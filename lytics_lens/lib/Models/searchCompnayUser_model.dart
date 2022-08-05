import 'dart:convert';

import 'package:get/get.dart';

List<SearchCompanyUsers> companyUsersFromJson(String str) => List<SearchCompanyUsers>.from(json.decode(str).map((x) => SearchCompanyUsers.fromJson(x)));

String companyUsersToJson(List<SearchCompanyUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCompanyUsers {
    SearchCompanyUsers({
        this.id,
        this.firstName,
        this.lastName,
    });

    String? id;
    String? firstName;
    String? lastName;
    var check = false.obs;

    factory SearchCompanyUsers.fromJson(Map<String, dynamic> json) => SearchCompanyUsers(
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
