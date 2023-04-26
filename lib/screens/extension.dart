import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => (MediaQuery.of(this).size.width / 390) * val;
  double dynamicHeight(double val) => (MediaQuery.of(this).size.height / 844) * val;
}
