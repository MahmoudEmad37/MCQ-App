
import 'package:get_storage/get_storage.dart';

class LocalStorage{

  void saveLanguage(String language)async{
    await GetStorage().write('lang', language);
  }

  Future<String> get languageSelected async{
    return await GetStorage().read('lang');
  }

}