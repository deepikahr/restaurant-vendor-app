import 'package:flutter/material.dart';

// const PRIMARY = const Color(0xFFFC830F);
const PRIMARY = const Color(0xFFE60D53); //primary color for eat out pal
final PRIMARY_LIGHT = const Color(0xFFFCA029);
final SECONDARY = const Color(0xFFEE3324);
final BORDER = const Color(0xF707070);
final BG_COLOR = const Color(0xFFF5F5F5);

final SUCCESS = const Color(0xFF00C000);
final DANGER = const Color(0xFFff5757);


final DARK_TEXT = const Color(0xFF555555);
final DARK_TEXT_A = const Color(0xFF8B8B8B);
final DARK_TEXT_B = const Color(0xFFF5F5F5);

final GRAY = const Color(0xFFAAABA9);

final WHITE = const Color(0xFFFFFFFF);
final WHITE_TEXT_B = const Color(0xFFf8f8f8);
final WHITE_B = const Color(0xFFf5f5f5);

TextStyle headerDefaultColor() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: WHITE,
  );
}

//----------------------------------- font family for main.dart ---------------------------

// const FONT_FAMILY = 'Roboto';

//--------------------------------- screen height & width ----------------------------------

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

//.................................. open - sans Light ....................................

TextStyle titleStyle() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: DARK_TEXT_A,
  );
}

TextStyle labelLarge() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: DARK_TEXT,
  );
}
TextStyle label() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    color: DARK_TEXT,
  );
}
TextStyle labelLight() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: GRAY,
  );
}
TextStyle textSuccess(){
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: SUCCESS,
  );
}
TextStyle textPrimary(){
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: PRIMARY,
  );
}
TextStyle textGray() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: GRAY,
  );
}