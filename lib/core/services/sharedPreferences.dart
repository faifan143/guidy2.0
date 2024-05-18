import 'dart:convert';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPref;

  Future<MyServices> init() async {
    sharedPref = await SharedPreferences.getInstance();
    return this;
  }


  T? getModel<T>({required String key, required T Function(dynamic) fromJson}) {
    String? modelJson = sharedPref.getString(key);
    if (modelJson != null) {
      dynamic decodedJson = jsonDecode(modelJson);
      return fromJson(decodedJson);
    }
    return null;
  }

}



initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
