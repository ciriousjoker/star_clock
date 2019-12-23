import 'dart:developer';
import 'dart:math' as prefix0;

import 'package:digital_clock/src/core/flare_controllers/digit_controller.dart';
import 'package:digital_clock/src/core/helpers/theme_helper.dart';
import 'package:digital_clock/src/ui/widgets/digit_layer.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class DigitWidget extends StatefulWidget {
  final int digit;
  static const String ANIMATION_ENTRY = "entry";
  static const String ANIMATION_IDLE = "idle";
  static const String ANIMATION_EXIT = "exit";

  const DigitWidget({Key key, this.digit}) : super(key: key);

  @override
  _DigitWidgetState createState() => _DigitWidgetState();
}

class _DigitWidgetState extends State<DigitWidget> {
  bool active = true;
  List<DigitController> digitController = [
    DigitController(),
    DigitController()
  ];

  bool isTransitioning = false;
  List<int> digits = [0, 0];
  // List<bool> hidden = [false, false];
  List<String> animation = ["idle", "idle"];

  int counter = 0;

  @override
  void initState() {
    super.initState();
    // digits[getLayer(!active)] = widget.digit;
    // active = !active;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.digit != digits[getLayer(!active)]) {
      digits[getLayer(!active)] = digits[getLayer(active)];
      digits[getLayer(active)] = widget.digit;

      animation[getLayer(active)] = DigitWidget.ANIMATION_ENTRY;
      animation[getLayer(!active)] = DigitWidget.ANIMATION_EXIT;
    }

    var ret = Container(
      key: Key("${++counter}"),
      // color: Colors.blue,
      child: Stack(
        children: [
          // Container(
          //   constraints: BoxConstraints(maxWidth: 40),
          //   child: FlareActor("assets/number_0.flr", animation: "entry",),
          // ),
          // Container(
          //   constraints: BoxConstraints(maxWidth: 40),
          //   child: FlareActor("assets/number_1.flr", animation: "entry",),
          // ),
          // Container(
          //   constraints: BoxConstraints(maxWidth: 40),
          //   child: FlareActor("assets/number_2.flr", animation: "entry",),
          // ),
          // Container(
          //   constraints: BoxConstraints(maxWidth: 40),
          //   child: FlareActor("assets/number_3.flr", animation: "entry",),
          // ),

          Container(
            constraints: BoxConstraints(maxWidth: 130),
            child: getAnimationLayer(0),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 130),
            child: getAnimationLayer(1),
          ),

          // Container(
          //   constraints: BoxConstraints(maxWidth: 40),
          //   child: FlareActor(
          //     "assets/number_${digits[0].toString()}.flr",
          //     animation: animation[0],
          //     // controller: flareController[layer],
          //     sizeFromArtboard: true,
          //   ),
          // ),
          // Container(
          //   constraints: BoxConstraints(maxWidth: 40),
          //   child: ,
          // ),
        ],
      ),
    );

    return ret;
  }

  Widget getAnimationLayer(int layer) {
    int digit = digits[layer];

    if (digit == null) {
      log("Digit is null");
      digit = 404;
    }

    // log("Layer: $layer | Digit: ${getDigitString(digit)} | Anim: ${animation[layer]}");

    // var theme = getClockTheme(context);

    return DigitLayer(
      animation: animation[layer],
      digit: digit,
    );
  }

  int getLayer(topIsActive) {
    return topIsActive ? 1 : 0;
  }

  String getDigitString(int digitOld) {
    // if (digitOld == 3) {
    //   return "1";
    // }

    String digitString = digitOld.toString();
    // if (digitTransition > 0) {
    //   digitString = "404";
    // }

    // log("Returned digit: $digitString");
    return digitString;
  }

  bool notNull(Object o) => o != null;
}
