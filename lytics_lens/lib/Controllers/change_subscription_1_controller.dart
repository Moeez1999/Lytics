import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChangeSubscription1Controller extends GetxController {
  
  bool isLoading = false;
  List intelligence = [];
  List allchannels = [];
  var last = 3;

  @override
  void onInit() {
    intelligence = [
      {'id': 'Transcription', 'name': 'Transcription', 'check': false},
      {'id': 'Translation', 'name': 'Translation', 'check': false},
      {'id': 'Sentiment', 'name': 'Sentiment', 'check': false},
      {
        'id': 'Speaker Recognition',
        'name': 'Speaker Recognition',
        'check': false
      },
    ];

    allchannels = [
      {
        'id': '24',
        'name': '24',
        'check': false,
      },
      {
        'id': '12',
        'name': '12',
        'check': false,
      },
      {
        'id': '6',
        'name': '6',
        'check': false,
      },
      {
        'id': '3',
        'name': '3',
        'check': false,
      },
      {
        'id': '1',
        'name': '1',
        'check': false,
      },
      
    ];

    update();

    super.onInit();
  }
}
