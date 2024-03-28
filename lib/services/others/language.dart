import 'dart:ui';

import 'package:get/get.dart';

enum EnumAppLanguage { mm, en }

class Language extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'mm': myanmar,
        'en': english,
      };

  Map<String, String> myanmar = {};

  Map<String, String> english = {};

  void changeLanguage({required EnumAppLanguage appLanguage}){
    Get.updateLocale(Locale(appLanguage.name));
  }

  void toggleLanguage(){
    String currentLocale = Get.locale!.languageCode;
    if(currentLocale == 'mm'){
      Get.updateLocale(Locale(EnumAppLanguage.en.name));
    }
    else{
      Get.updateLocale(Locale(EnumAppLanguage.mm.name));
    }

  }

}

bool xEnLang() {
  return Get.locale!.languageCode == 'en';
}
