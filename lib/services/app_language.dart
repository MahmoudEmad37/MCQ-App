import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mcq/utils/local_storage/local_storage.dart';

class AppLanguage extends GetxController {
  var appLocal = 'en';

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    LocalStorage localStorage = LocalStorage();
    appLocal = await localStorage.languageSelected == null
        ? 'en'
        : await localStorage.languageSelected;
    Get.updateLocale(Locale(appLocal));
    update();
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();

    if (appLocal == type) {
      return;
    }
    if (type == 'en') {
      appLocal = 'en';
      localStorage.saveLanguage('en');
    } else {
      appLocal = 'ar';
      localStorage.saveLanguage('ar');
    }
    update();
  }
}
