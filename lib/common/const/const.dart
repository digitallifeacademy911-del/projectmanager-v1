import 'package:flutter/material.dart';
import 'package:projectmanager/common/theme/pallette.dart';

class AppConst {
  static double authTopPadding = 50;
  static EdgeInsets bodyPadding = EdgeInsets.symmetric(horizontal: 20);
  static Radius inputRadius = Radius.circular(10);
  static Radius bodyRadius = Radius.circular(50);

  static InputBorder inputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(AppConst.inputRadius),
  );
  static InputBorder inputClickedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: PalleteColor.backgroundColor),
    borderRadius: BorderRadius.all(AppConst.inputRadius),
  );

  static double h1 = 64;
  static double h2 = 32;
  static double p = 20;
}
