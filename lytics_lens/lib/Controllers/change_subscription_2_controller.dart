import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeSubscription2Controller extends GetxController {
  bool isLoading = false;
  List userdata = [];
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  bool isportal = false;
  bool isapp = false;
  @override
  void onInit() {
    userdata = [
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': false,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': false,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': false,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': false,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': false,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 645',
        'isapp': true,
      },
      {
        'id': 'Jamshed Patel',
        'name': 'Jamshed Patel',
        'email': 'jamshed.patel@lytics.app',
        'number': '+92 332 6489 ',
        'isapp': true,
      },
    ];

    update();

    super.onInit();
  }
}
