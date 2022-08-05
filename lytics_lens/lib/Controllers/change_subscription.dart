import 'package:get/get.dart';

class ChangeSubscriptionController extends GetxController {
  bool isLoading = false;
  List alltopic = [];
  List allchannels = [];

  @override
  void onInit() {
    alltopic = [
      {'id': 'TV', 'name': 'TV', 'check': false},
      {'id': 'Print', 'name': 'Print', 'check': false},
      {'id': 'Websites', 'name': 'Websites', 'check': false},
      {'id': 'Social Media', 'name': 'Social Media', 'check': false},
      {'id': 'Online Videos', 'name': 'Online Videos', 'check': false},
    ];

    allchannels = [
      {
        'id': 'DAWN News',
        'name': 'DAWN News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'GEO News',
        'name': 'GEO News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': '24 News',
        'name': '24 News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'Capital News',
        'name': 'Capital News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'AAJ News',
        'name': 'AAJ News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'Duniya News',
        'name': 'Duniya News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'ARY News',
        'name': 'ARY News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': '24 News',
        'name': '24 News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'Capital News',
        'name': 'Capital News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'AAJ News',
        'name': 'AAJ News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'DAWN News',
        'name': 'DAWN News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'GEO News',
        'name': 'GEO News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': '24 News',
        'name': '24 News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'Capital News',
        'name': 'Capital News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
      {
        'id': 'AAJ News',
        'name': 'AAJ News',
        'check': false,
        'image': 'assets/images/dawn.png'
      },
    ];

    update();

    super.onInit();
  }
}
