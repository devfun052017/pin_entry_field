library pin_entry_field;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinEntryStyle {
  final TextStyle textStyle;
  final double fieldPadding;
  final Color fieldBackgroundColor;
  final BoxBorder fieldBorder;
  final BorderRadiusGeometry fieldBorderRadius;

  PinEntryStyle({
    this.textStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    this.fieldBackgroundColor,
    this.fieldPadding,
    this.fieldBorder,
    this.fieldBorderRadius,
  });
}
