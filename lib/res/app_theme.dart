import 'package:flutter/material.dart';
// ignore_for_file: deprecated_member_use

class AppTheme {
  static String fontFamilyName = 'Montserrat';

  static ThemeData lightMode({Color? kPrimaryColor, Color? kBackgroundColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: const Color(0xFFF9FCFF),
      shadowColor: const Color(0xFFdedcdc),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor?.withOpacity(0.2),
      hoverColor: kPrimaryColor?.withOpacity(0.1),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFFFFFFFF),
      disabledColor: const Color(0xFFD3D9DD),
      textTheme: buildTextTheme(base: base.textTheme, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, myFontFamily: fontFamily),
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      colorScheme: const ColorScheme.light().copyWith(
        error: errorColor,
        primary: kPrimaryColor,
        background: kBackgroundColor,
      ),

      // Widgets Theme
      appBarTheme: AppBarTheme(color: kPrimaryColor, foregroundColor: Colors.white, surfaceTintColor: Colors.transparent),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFFF9FCFF),
      ),
      popupMenuTheme: const PopupMenuThemeData(color: Color(0xFFFFFFFF)),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FCFF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor ?? const Color(0xFF000000), width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: base.iconTheme.color,
      ),
    );
  }

  static ThemeData darkMode({Color? kPrimaryColor, Color? kBackgroundColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: false,
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: const Color(0xFF181818),
      shadowColor: const Color(0x8F000000),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor?.withOpacity(0.2),
      hoverColor: kPrimaryColor?.withOpacity(0.1),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFF1E1E1E),
      disabledColor: const Color(0xFFCCCCCC),
      textTheme: buildTextTheme(base: base.textTheme, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, myFontFamily: fontFamily),
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      colorScheme: const ColorScheme.dark().copyWith(
        error: errorColor,
        primary: kPrimaryColor,
        background: kBackgroundColor,
      ),

      // Widgets Theme
      appBarTheme: AppBarTheme(color: kPrimaryColor),
      popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF303642)),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor ?? const Color(0xFF000000), width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: base.iconTheme.color,
      ),
    );
  }

/* ===================> Custom TextStyle <================== */
  static TextTheme buildTextTheme({required TextTheme base, String? myFontFamily}) {
    return base.copyWith(
      /// Body Text
      bodyLarge: TextStyle(fontSize: 16.0, letterSpacing: 0.5, fontWeight: FontWeight.w400, color: base.bodyLarge!.color, fontFamily: myFontFamily),

      /// This style is flutter default body textStyle (without textStyle) ///
      bodyMedium: TextStyle(fontSize: 14.0, letterSpacing: 0.25, fontWeight: FontWeight.w400, color: base.bodyMedium!.color, fontFamily: myFontFamily),

      /// Head Line
      displayLarge: TextStyle(fontSize: 96.0, letterSpacing: -1.5, fontWeight: FontWeight.w300, color: base.displayLarge!.color, fontFamily: myFontFamily),
      displayMedium: TextStyle(fontSize: 60.0, letterSpacing: -0.5, fontWeight: FontWeight.w300, color: base.displayMedium!.color, fontFamily: myFontFamily),
      displaySmall: TextStyle(fontSize: 48.0, letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.displaySmall!.color, fontFamily: myFontFamily),
      headlineMedium: TextStyle(fontSize: 34.0, letterSpacing: 0.25, fontWeight: FontWeight.w400, color: base.headlineMedium!.color, fontFamily: myFontFamily),
      headlineSmall: TextStyle(fontSize: 24.0, letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineSmall!.color, fontFamily: myFontFamily),
      titleLarge: TextStyle(fontSize: 20.0, letterSpacing: 0.15, fontWeight: FontWeight.w500, color: base.titleLarge!.color, fontFamily: myFontFamily),

      /// Sub Title
      titleMedium: TextStyle(fontSize: 16.0, letterSpacing: 0.15, fontWeight: FontWeight.w400, color: base.titleMedium!.color, fontFamily: myFontFamily),
      titleSmall: TextStyle(fontSize: 14.0, letterSpacing: 0.1, fontWeight: FontWeight.w500, color: base.titleSmall!.color, fontFamily: myFontFamily),

      /// Caption
      bodySmall: TextStyle(fontSize: 12.0, letterSpacing: 0.4, fontWeight: FontWeight.w400, color: base.bodySmall!.color, fontFamily: myFontFamily),

      /// Over Line
      labelSmall: TextStyle(fontSize: 10.0, letterSpacing: 1.5, fontWeight: FontWeight.w400, color: base.labelSmall!.color, fontFamily: myFontFamily),

      /// Button
      labelLarge: TextStyle(fontSize: 14.0, letterSpacing: 1.25, fontWeight: FontWeight.w400, color: base.labelLarge!.color, fontFamily: myFontFamily),
    );
  }
}
