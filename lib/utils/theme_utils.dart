import 'package:flutter/material.dart';

ThemeMode themeStringToThemeMode(String themeValue){
  ThemeMode theme = ThemeMode.light;
  switch (themeValue) {
    case "light":
      theme = ThemeMode.light;
      break;
    case "dark":
      theme = ThemeMode.dark;
      break;
    case "system":
      theme = ThemeMode.system;
      break;
  }
  return theme;
}