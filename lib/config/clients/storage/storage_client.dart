import 'package:general_app/config/clients/api/api_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum StorageClientKeys {
  language, //String
  notifications, //int
  apiToken, //String
  isDarkMode, //String
}

class StorageClient {
  final GetStorage _box = GetStorage();

  Future init() async {
    await GetStorage.init();
    if (get(StorageClientKeys.isDarkMode) == null) {
      await save(StorageClientKeys.isDarkMode, false);
    }
  }

  String getAppLanguage() =>
      get(StorageClientKeys.language) ?? Get.deviceLocale!.languageCode;

  bool isLogged() => get(StorageClientKeys.apiToken) != null;

  String? apiToken() => get(StorageClientKeys.apiToken);

  bool isAr() => get(StorageClientKeys.language) == 'ar';

  /// ============= ============== ===================  =================
  Future save(StorageClientKeys storageClientKeys, dynamic value) async {
    await GetStorage().write(storageClientKeys.name, value);
  }

  dynamic get(StorageClientKeys storageClientKeys) {
    return GetStorage().read(storageClientKeys.name);
  }

  Future<void> signOut() async {
    await _box.erase();
    // Get.offAll(()=>LoginScreen());
    APIClient.instance.updateTokenHeader(null);
  }
}
