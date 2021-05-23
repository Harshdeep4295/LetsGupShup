import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letsgupshup/core/styles/app_dimens.dart';

class TextView extends Text {
  TextView(
    String displayString,
    double fontSize,
    FontWeight fontWeight,
    Color textColor,
  ) : super(
          displayString,
          style: TextStyle(
            color: textColor,
            fontSize: fontValue(fontSize),
            fontWeight: fontWeight,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
        );
}

class SmallTextView extends TextView {
  SmallTextView(
    String displayString, {
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color textColor = Colors.black,
  }) : super(
          displayString,
          fontSize,
          fontWeight,
          textColor,
        );
}

class MediumTextView extends TextView {
  MediumTextView(
    String displayString, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    Color textColor = Colors.black,
  }) : super(
          displayString,
          fontSize,
          fontWeight,
          textColor,
        );
}

class LargeTextView extends TextView {
  LargeTextView(
    String displayString, {
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w500,
    Color textColor = Colors.black,
  }) : super(
          displayString,
          fontSize,
          fontWeight,
          textColor,
        );
}
