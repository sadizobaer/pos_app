//==============custom text styles================
//------------------------------------------------

import 'package:flutter/material.dart';
import 'colors.dart';

TextStyle regularText(double size, {Color color = black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
    );

TextStyle mediumText(double size, {Color color = black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    );

TextStyle semiBoldText(double size, {Color color = black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
    );

TextStyle boldText(double size, {Color color = black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
    );

TextStyle extraBoldText(double size, {Color color = black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w900,
    );
