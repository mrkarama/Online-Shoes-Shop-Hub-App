import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableText(String text, Color color, double fontSize, double height,
    FontWeight fontWeight,
    {FontStyle? fontStyle = FontStyle.normal}) {
  return Text(
    maxLines: 1,
    textAlign: TextAlign.justify,
    overflow: TextOverflow.ellipsis,
    text,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      fontStyle: fontStyle,
    ),
  );
}

Widget reusableTextWithMaxLines(String text, Color color, int? maxlines,
    double fontSize, double height, FontWeight fontWeight,
    {FontStyle? fontStyle = FontStyle.normal}) {
  return Text(
    textAlign: TextAlign.justify,
    maxLines: maxlines,
    overflow: TextOverflow.ellipsis,
    text,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      fontStyle: fontStyle,
    ),
  );
}
