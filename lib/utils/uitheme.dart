import 'package:flutter/material.dart';

class Custom extends ThemeExtension<Custom> {
  final double? backgroundImageOpacity;

  const Custom({this.backgroundImageOpacity});

  @override
  Custom copyWith({double? backgroundImageOpacity}) {
    return Custom(
      backgroundImageOpacity:
          backgroundImageOpacity ?? this.backgroundImageOpacity,
    );
  }

  @override
  Custom lerp(ThemeExtension<Custom>? other, double t) {
    if (other is! Custom) return this;
    return Custom(
      backgroundImageOpacity:
          backgroundImageOpacity != null && other.backgroundImageOpacity != null
              ? backgroundImageOpacity! * (1.0 - t) +
                  other.backgroundImageOpacity! * t
              : backgroundImageOpacity,
    );
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  hintColor: Colors.blueAccent,
  primaryColorLight: Colors.orange,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange, // Set FAB color to orange
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.orange, // Set selected item color to orange
    unselectedItemColor: Colors.grey,
  ),
  extensions: [
    Custom(
      backgroundImageOpacity: 0.15,
    ),
  ],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  scaffoldBackgroundColor: Colors.black,
  primaryColorDark: Colors.orange,
  cardColor: Colors.orange,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange, // Set FAB color to orange
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // backgroundColor: Colors.grey[900],
    selectedItemColor: Colors.orange, // Set selected item color to orange
    // unselectedItemColor: Colors.grey,
  ),
  hintColor: Colors.blueAccent,
  extensions: [
    Custom(
      backgroundImageOpacity: 0.05,
    ),
  ],
);
