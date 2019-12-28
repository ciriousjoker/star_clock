import 'package:digital_clock/src/core/helpers/state_helper.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class DigitLayer extends StatefulWidget {
  static const String ANIMATION_ENTRY = "entry";
  static const String ANIMATION_IDLE = "idle";

  /// Set to -1 to display a colon
  final int digit;
  final String animation;

  final ClockTheme theme;
  final WeatherCondition weather;
  final DateTime dateTime;

  const DigitLayer({
    Key key,
    @required this.digit,
    @required this.animation,
    @required this.theme,
    @required this.dateTime,
    @required this.weather,
  }) : super(key: key);

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
    String filename = widget.digit.toString();
    if (widget.digit == -1) {
      filename = "colon";
    }

    return FlareActor(
      "assets/numbers/$filename.flr",
      animation: animation,
      color: getDigitColor(),
      callback: (name) {
        if (name == DigitLayer.ANIMATION_ENTRY) {
          setState(() {
            animation = DigitLayer.ANIMATION_IDLE;
          });
        }
      },
      sizeFromArtboard: false,
    );
  }

  Color getDigitColor() {
    return isDark(widget.theme, widget.dateTime, widget.weather)
        ? Colors.white
        : Colors.blueGrey.shade900;
  }
}
