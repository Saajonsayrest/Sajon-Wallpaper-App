import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration getDefaultDecoration() => BoxDecoration(
      borderRadius: getDefaulBorderRadius(),
      color: Colors.white,
    );

BorderRadius getDefaulBorderRadius() => BorderRadius.circular(16.r);

BoxDecoration getShadowDecoration({
  bool isPurple = false,
  bool linearGradient = false,
  bool noShadow = false,
  double borderRadius = 12,
  Color color = Colors.white,
  BoxBorder? border,
}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius.r),
      border: border,
      gradient: linearGradient == true
          ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff242424), Color(0xff0A2935)],
            )
          : null,
      boxShadow: [
        BoxShadow(
          color: isPurple == false
              ? Colors.black.withOpacity(0.1)
              : noShadow == false
                  ? const Color(0xffebecfc)
                  : Colors.white,
          blurRadius: 10.r,
          offset: const Offset(0, 4),
          spreadRadius: 0.r,
        ),
      ],
    );

BoxDecoration getButtonDecoration(
        {bool isPurple = false,
        double borderRadius = 1,
        int color = 0xffffffff,
        bool isBorder = false,}) =>
    BoxDecoration(
      color: Color(color),
      borderRadius: BorderRadius.circular(borderRadius.r),
      border: isBorder ? Border.all() : Border.all(color: Colors.transparent),
      boxShadow: [
        BoxShadow(
          color: isPurple == false
              ? Colors.black.withOpacity(0.1)
              : const Color(0xffebecfc),
          blurRadius: 10.r,
          offset: const Offset(0, 4),
          spreadRadius: 0.r,
        ),
      ],
    );

BoxDecoration getRandomColorDecoration({bool isPurple = false}) {
  final color = <Color>[
    const Color(0xfff5fcfc),
    const Color(0xfffff3f5),
    const Color(0xfff5f6f6),
    const Color(0xfff7f7fb)
  ];
  return BoxDecoration(
    color: color[Random().nextInt(color.length)],
    borderRadius: BorderRadius.circular(15.r),
    boxShadow: [
      BoxShadow(
        color: isPurple == false
            ? Colors.black.withOpacity(0.1)
            : const Color(0xffebecfc),
        blurRadius: 10.r,
        offset: const Offset(0, 4),
        spreadRadius: 0.r,
      ),
    ],
  );
}
