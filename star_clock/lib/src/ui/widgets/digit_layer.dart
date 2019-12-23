import 'dart:developer';
import 'dart:math' as prefix0;

import 'package:digital_clock/src/core/flare_controllers/digit_controller.dart';
import 'package:digital_clock/src/core/helpers/theme_helper.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class DigitLayer extends StatefulWidget {
  final int digit;
  final String animation;

  static const String ANIMATION_ENTRY = "entry";
  static const String ANIMATION_IDLE = "idle";
  static const String ANIMATION_EXIT = "exit";

  const DigitLayer({Key key, this.digit, this.animation}) : super(key: key);

  @override
  _DigitWidgetState createState() => _DigitWidgetState();
}

class _DigitWidgetState extends State<DigitLayer> {
  bool active = true;
  String animation;

  @override
  void initState() {
    super.initState();
    animation = widget.animation;
  }

  @override
  Widget build(BuildContext context) {
    // controllerCurrent.onCompleted("entry");

    print("DigitLayer build()");

    return FlareActor(
      "assets/number_${widget.digit.toString()}.flr",
      animation: animation,
      color: getClockTheme(context) == ClockTheme.day
          ? Colors.blueGrey.shade900
          : Colors.white,
      callback: (name) {
        print("Animation done: " + name);
        if (name == DigitLayer.ANIMATION_ENTRY) {
          setState(() {
            animation = DigitLayer.ANIMATION_IDLE;
          });
        }
      },
      sizeFromArtboard: true,
    );
  }

  bool notNull(Object o) => o != null;
}
