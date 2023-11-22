import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color kPrimaryColor = const Color(0xff0B1C2D);
  static Color kBackgroundColor = const Color(0xFF828282);
  static Color litePurple = const Color(0xFFD6ECF9);
  static Color errorColor = const Color(0xffFF6B6B);
  static Color lightRed = const Color(0xffE0F1FB);
  static Color green = const Color(0xff189A16);
  static Color hintColor = const Color(0xffBFBFBF);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color red = Colors.red;
  static Color mediumRed = const Color(0xFFDE554F);
  static Color darkRed = const Color(0xffC50000);
  static Color blackColor = const Color(0xff1E2035);
  static Color grey = const Color(0xffD9D9D9);

  static Color selectedTab = const Color(0xff2C2335).withOpacity(0.06);
  static Color searchFiledHintText = const Color(0xff4A4A4A);

  static Color groupSubText = const Color(0xff5C5C5C);
  static Color groupCardBorder = const Color(0xffDEDEDE);
  static Color copyBackground = const Color(0xffFCF9FF);
  static Color whiteTransparent = const Color(0xffF8F8F8).withOpacity(0.63);
  static Color allGroupsText = const Color(0xffA6A6A6);

  static List<Color> bannerGradientColorList = [
    const Color(0xff169A8A).withOpacity(0.1),
    const Color(0xffFFD83D).withOpacity(0.1),
    const Color(0xffFFD83D).withOpacity(0.1),
    const Color(0xffFF417E).withOpacity(0.1),
  ];
  static Color disableInput = const Color(0xffFBEFEF);

  static Color hintText = const Color(0xffA8A8A8);
  static Color pickedImageBgColor = const Color(0xffF8F0FF);
  static Color groupPhoto = const Color(0xff2C2335).withOpacity(0.33);
  static Color pickImageBorder = const Color(0xffE8E8E8);
  static Color greyFontColor = const Color(0xff858585);
  static Color greyBorderColor = const Color(0xffCBCBCB);

  static Color lightYellow = const Color(0xffFFEFC6);
  static Color unselectedEmoji = const Color(0xfffeeb97);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
