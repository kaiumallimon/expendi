import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Core Colors
  static const Color primaryColor = Color(0xFFF54A14);
  static const Color secondaryColor = Color(0xFF46A7DF);
  static const Color tertiaryColor = Color(0xFFDADADA);

  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF000000);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onTertiary = Color(0xFF000000);

  static const Color onLightBackground = Color(0xFF000000);
  static const Color onDarkBackground = Color(0xFFFFFFFF);

  static const String fontFamily = 'SF Pro Text';

  // ---------- LIGHT THEME ----------
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: lightBackground,
    primaryColor: primaryColor,

    fontFamily: fontFamily,

    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      background: lightBackground,
      surface: Colors.white,
      error: Colors.red,

      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onTertiary: onTertiary,
      onBackground: onLightBackground,
      onSurface: onLightBackground,
      surfaceContainer: darkBackground,
      onSurfaceVariant: onDarkBackground,
      onError: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: onLightBackground,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tertiaryColor.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  // ---------- DARK THEME ----------
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: fontFamily,

    scaffoldBackgroundColor: darkBackground,
    primaryColor: primaryColor,

    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      background: darkBackground,
      surface: Color(0xFF121212),
      error: Colors.redAccent,

      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onTertiary: onTertiary,
      onBackground: onDarkBackground,
      onSurface: onDarkBackground,
      onError: Colors.black,
      surfaceContainer: lightBackground,
      onSurfaceVariant: onLightBackground,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: onDarkBackground,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF121212),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
  );
}
