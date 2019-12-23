import 'dart:developer';
import 'dart:math' as prefix0;

import 'package:digital_clock/src/core/flare_controllers/digit_controller.dart';
import 'package:digital_clock/src/core/helpers/theme_helper.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class DigitWidget2 extends StatefulWidget {
  final int digit;

  const DigitWidget2({Key key, this.digit}) : super(key: key);

  @override
  _DigitWidgetState createState() => _DigitWidgetState();
}

class _DigitWidgetState extends State<DigitWidget2> {
  bool active = true;
  List<DigitController> digitController = [
    DigitController(),
    DigitController()
  ];

  bool isTransitioning = false;
  List<int> digits = [0, 0];

  int counter = 0;

  @override
  void initState() {
    super.initState();
    // digits[getLayer(!active)] = widget.digit;
    // active = !active;
  }

  @override
  Widget build(BuildContext context) {
    // controllerCurrent.onCompleted("entry");

    // digits[getLayer(active)] = digit1;

    // Run transition animations if necessary

    // if (widget.digit != digits[getLayer(active)]) {

    // counter++;
    // int newval = (counter % 4) + 0;
    // int newval = (prefix0.Random().nextInt(1000) % 4) + 1;
    // log("Value: ${widget.digit}");

    if (widget.digit != digits[getLayer(!active)]) {
      // log("Digits (before): ${digits[getLayer(active)]}, ${digits[getLayer(!active)]}");
      // log("Digits (after): ${digits[getLayer(active)]}, ${digits[getLayer(!active)]}");

      // animation[getLayer(active)] = DigitWidget.ANIMATION_ENTRY;
      // animation[getLayer(!active)] = DigitWidget.ANIMATION_EXIT;

      digits[getLayer(!active)] = digits[getLayer(active)];
      digits[getLayer(active)] = widget.digit;

      digitController[getLayer(!active)].exit();
    }

    var ret = Container(
      // key: Key("${++counter}"),
      // color: Colors.blue,
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 130),
            child: getAnimationLayer(0),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 130),
            child: getAnimationLayer(1),
          ),
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

    var theme = getClockTheme(context);
    return FlareActor(
      "assets/number_${digits[layer].toString()}.flr",
      controller: digitController[layer],
      color: theme == ClockTheme.day ? Colors.blueGrey.shade900 : Colors.white,
      callback: (name) {
        print("Animation done: " + name);
        // if (name == DigitWidget.ANIMATION_ENTRY) {
        //   // flareController[layer].play(DigitWidget.ANIMATION_IDLE);
        //   setState(() {
        //     animation[layer] = DigitWidget.ANIMATION_IDLE;
        //   });
        // }
      },
      sizeFromArtboard: true,
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
