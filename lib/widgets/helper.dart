import 'package:flutter/material.dart';

Widget conditionalBuilder({
  required bool condition,
  required Function trueWrapper,
  required Widget child,
  required Function falseWrapper,
}) {
  if (condition) {
    return trueWrapper(child);
  } else {
    return falseWrapper(child);
  }
}
