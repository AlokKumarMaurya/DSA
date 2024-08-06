import 'package:get_storage/get_storage.dart';
import 'package:local_storage/get_storage/get_storage_key.dart';

class AppLocalStorage {
  static final AppLocalStorage _appLocalStorage = AppLocalStorage._internal();

  factory AppLocalStorage() {
    GetStorage.init();
    return _appLocalStorage;
  }

  AppLocalStorage._internal();

  final _box = GetStorage();

  bool isLoggedIn() {
    return _box.read(GetStorageKey.isLoggedIn) ?? false;
  }

  void setLoginStatus({required bool isLoggedIn}) {
    _box.write(GetStorageKey.isLoggedIn, isLoggedIn);
  }

  void deleteStorage() {
    _box.erase();
  }

  String getUserId() {
    return _box.read(GetStorageKey.userId) ?? "";
  }

  void setUserId({required String userId}) {
    _box.write(GetStorageKey.userId, userId);
  }

  void saveFcmToken({required String token}) {
    _box.write(GetStorageKey.fcmToken, token);
  }

  String getFcmToken() {
    return _box.read(GetStorageKey.fcmToken) ?? "";
  }
}
