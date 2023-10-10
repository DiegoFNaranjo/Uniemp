import 'package:flutter/material.dart';

//metodo para definir color dePrimarySwatch en main. dart (http://mcg.mbitson.com/)

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE1F1EA),
  100: Color(0xFFB4DBC9),
  200: Color(0xFF82C4A6),
  300: Color(0xFF4FAC82),
  400: Color(0xFF2A9A67),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF038045),
  700: Color(0xFF03753C),
  800: Color(0xFF026B33),
  900: Color(0xFF015824),
});
const int _primaryPrimaryValue = 0xFF04884C;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFF8AFFAE),
  200: Color(_primaryAccentValue),
  400: Color(0xFF24FF67),
  700: Color(0xFF0AFF55),
});
const int _primaryAccentValue = 0xFF57FF8A;