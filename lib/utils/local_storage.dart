import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../res/color_print.dart';

class Prefs {
  static const String userID = "USER_ID";
  static const String lastBackup = "LAST_BUCK_UP";
  static const String userEmail = "USER_EMAIL";
}

class LocalStorage {
  static GetStorage prefs = GetStorage();

  static RxString firebaseUid = "".obs;
  static RxString lastBackup = "".obs;
  static RxString userEmail = "".obs;

  static Future storeDataInfo({required String uid, required String userEmaIL}) async {
    await prefs.write(Prefs.userID, uid);
    firebaseUid.value = prefs.read(Prefs.userID) ?? "";

    await prefs.write(Prefs.userEmail, userEmaIL);
    userEmail.value = prefs.read(Prefs.userEmail) ?? "";
  }

  static Future storeBackUpTime({required String backUpTime}) async {
    await prefs.write(Prefs.lastBackup, backUpTime);
    lastBackup.value = prefs.read(Prefs.lastBackup) ?? "";
  }

  static Future<void> clearLocalStorage({bool clearDeviceData = false}) async {
    await prefs.erase();
    firebaseUid = "".obs;
    lastBackup = "".obs;
    userEmail = "".obs;
  }

  static Future<void> readDataInfo() async {
    firebaseUid.value = prefs.read(Prefs.userID) ?? "";
    userEmail.value = prefs.read(Prefs.userEmail) ?? "";
    lastBackup.value = prefs.read(Prefs.lastBackup) ?? "";
  }

  static Future<void> printLocalStorageData() async {
    printData(key: "User userID", value: firebaseUid.value);
    printData(key: "User email", value: userEmail.value);
    printData(key: "Last backup", value: lastBackup.value);
  }
}
