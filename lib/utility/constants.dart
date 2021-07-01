import 'package:flutter/material.dart';

class KampongColors {
  static const blue = const Color.fromRGBO(1, 22, 39, 1.0);
  static const aquamarine = const Color.fromRGBO(134, 250, 187, 1.0);
  static const sand = const Color.fromRGBO(255, 244, 214, 1.0);
  static const tangerine = const Color.fromRGBO(255, 198, 51, 1.0);
  static const slab = const Color.fromRGBO(240, 240, 240, 1.0);
  static const red = const Color.fromRGBO(204, 51, 0, 1.0);
  static const black = const Color.fromRGBO(0, 0, 0, 1.0);
  static const white = const Color.fromRGBO(255, 255, 255, 1.0);
  static const tileText = const Color.fromRGBO(246, 247, 248, 1.0);
  static const transparent = const Color.fromRGBO(0, 0, 0, 0);
}

class KampongFonts {
  static const countryDropDown = const TextStyle(
    color: KampongColors.black,
    fontSize: 15,
  );

  static const tileText = const TextStyle(
    color: KampongColors.tileText,
    fontSize: 23,
    fontWeight: FontWeight.w600,
  );

  static const header = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 25,
    color: Colors.black,
  );

  static const headerUnbold = const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 25,
    color: Colors.black,
  );

  static const subHeader = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const label = const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: Colors.black,
  );

  static const labelAlt = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Colors.black87,
  );

  static const labelDesc = const TextStyle(
    fontSize: 11,
  );

  static const sos = const TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );

  static const bodyText = const TextStyle(
    fontSize: 12,
  );
}
