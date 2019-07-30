import 'package:flutter/material.dart';

class MeasurementLine {
  int value;
  Line type;

  MeasurementLine({this.value, @required this.type});
}

enum Line {
  big,
  medium,
  small,
}
