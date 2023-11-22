import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../res/app_strings.dart';
import '../res/color_print.dart';
import 'local_storage.dart';
import 'ui_utils.dart';

const double defaultPadding = 18.0;
const double defaultRadius = 8.0;

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null || value.isEmpty || value == "null" || value == "" || value == "NULL");
}

/// ------ To Check Internet Ability -------------------->>>
ConnectivityResult? connectivityResult;
final Connectivity connectivity = Connectivity();
Future<bool> getConnectivityResult({bool showToast = true}) async {
  try {
    connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      if (showToast == true) {
        UiUtils.toast(AppStrings.noInternetAvailable);
      }
      return false;
    }
  } on PlatformException catch (e) {
    printWarning(e);
    if (showToast == true) {
      UiUtils.toast(AppStrings.noInternetAvailable);
    }
    return false;
  }
}

Future<int> checkTimeDuration() async {
  try {
    int returnDays = DateTime.now().difference(DateTime.parse(LocalStorage.lastBackup.value)).inDays;
    printData(key: "checkTimeDuration", value: returnDays);
    return returnDays;
  } catch (e) {
    return 0;
  }
}

enum BackUpType { daily, weekly, never }

Future<BackUpType> convertBackUpType({required String backUpType}) async {
  BackUpType returnBackUpType;

  switch (backUpType) {
    case 'daily':
      returnBackUpType = BackUpType.daily;
      break;
    case 'weekly':
      returnBackUpType = BackUpType.weekly;
      break;
    case 'never':
      returnBackUpType = BackUpType.never;
      break;
    default:
      returnBackUpType = BackUpType.weekly;
  }

  printData(key: "Return BackUp Type", value: returnBackUpType);
  return returnBackUpType;
}

Future<String> convertStringToBackUpType({required BackUpType backUpType}) async {
  String returnBackUpType;

  switch (backUpType) {
    case BackUpType.daily:
      returnBackUpType = "daily";
      break;
    case BackUpType.weekly:
      returnBackUpType = "weekly";
      break;
    case BackUpType.never:
      returnBackUpType = "never";
      break;
    default:
      returnBackUpType = "weekly";
  }

  printData(key: "Return BackUp Type", value: returnBackUpType);
  return returnBackUpType;
}

BoxBorder defaultBorder = Border.all(color: const Color(0xffE8E8E8));

DateTime defaultDateTime = DateTime.parse("1999-01-01 12:00:00.974368");

Future<Map<String, String>> initPlatformState() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  RxString deviceId = "".obs;
  RxString deviceType = "".obs;
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = (await deviceInfoPlugin.androidInfo);
      deviceId.value = androidDeviceInfo.id;
      deviceType.value = "android";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = (await deviceInfoPlugin.iosInfo);
      deviceId.value = iosDeviceInfo.identifierForVendor ?? "";
      deviceType.value = "ios";
    }
    printData(key: "device_id", value: deviceId);
    printData(key: "device_type", value: deviceType);
  } catch (e) {
    debugPrint(e.toString());
  }

  return {
    "device_id": deviceId.value,
    "device_type": deviceType.value,
  };
}

extension StrExtension on String {
  static String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }
}
