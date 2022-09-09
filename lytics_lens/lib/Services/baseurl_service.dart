import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseUrlService extends GetxService
{
  final storage = new GetStorage();
  String baseUrl = '';

  Future<BaseUrlService> init() async {
    await isBaseUrlCheck();
    return this;
  }


  Future<String> isBaseUrlCheck() async {

    if (storage.hasData("Url")) {
      baseUrl = storage.read("Url");
    } else {
      baseUrl = 'http://125.209.105.142:3000';
    }
    return baseUrl;
  }


}