import 'package:flutter/material.dart';

// const PRIMARY = const Color(0xFFFC830F);
const PRIMARY = const Color(0xFFB6236C); //primary color for eat out pal
const PRIMARY_LIGHT = const Color(0xFFFCA029);
const SECONDARY = const Color(0xFFEE3324);
const BORDER = const Color(0xF707070);
const BG_COLOR = const Color(0xFFF5F5F5);

const SUCCESS = const Color(0xFF00C000);
const DANGER = const Color(0xFFff5757);

const DARK_TEXT = const Color(0xFF555555);
const DARK_TEXT_A = const Color(0xFF8B8B8B);
const DARK_TEXT_B = const Color(0xFFF5F5F5);

const GRAY = const Color(0xFFAAABA9);

const WHITE = const Color(0xFFFFFFFF);
const WHITE_TEXT_B = const Color(0xFFf8f8f8);
const WHITE_B = const Color(0xFFf5f5f5);

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
    color: Colors.black,
  );
}

TextStyle labelLarge() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: Colors.black,
  );
}

TextStyle label() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    color: Colors.black,
  );
}

TextStyle labelLight() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.black,
  );
}

TextStyle textSuccess() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.black,
  );
}

TextStyle textPrimary() {
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
    color: Colors.black,
  );
}

TextStyle whitetext() {
  return TextStyle(
      fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.white);
}

TextStyle primaryText() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: PRIMARY,
  );
}

TextStyle blacktext() {
  return TextStyle(
      fontWeight: FontWeight.w500, fontSize: 13.0, color: Colors.black);
}

TextStyle greytext() {
  return TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0, color: GRAY);
}

TextStyle boldtext() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: Colors.black,
  );
}

TextStyle boldwhite() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
  );
}

TextStyle orderDetailsRejectbtn() {
  return TextStyle(
    color: Color(0xFF4A4F59),
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
}

TextStyle orderDetailsBoldPrice() {
  return TextStyle(
    color: PRIMARY,
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );
}
