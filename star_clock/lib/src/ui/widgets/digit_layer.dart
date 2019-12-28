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

  const DigitLayer({
    Key key,
    this.digit,
    this.animation,
    this.theme,
    this.weather,
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
        // print("Animation done: " + name);
        if (name == DigitLayer.ANIMATION_ENTRY) {
          setState(() {
            animation = DigitLayer.ANIMATION_IDLE;
          });
        }
      },
      sizeFromArtboard: true,
    );
  }

  Color getDigitColor() {
    if (widget.theme == ClockTheme.night) {
      return Colors.white;
    }

    // Weather exceptions
    if (widget.weather == WeatherCondition.thunderstorm ||
        widget.weather == WeatherCondition.rainy ||
        widget.weather == WeatherCondition.windy ||
        // widget.weather == WeatherCondition.snowy ||
        widget.weather == WeatherCondition.cloudy) {
      return Colors.white;
    }

    // Default color for day/night
    if (DateTime.now().hour < 8 || DateTime.now().hour > 20) {
      return Colors.white;
    } else {
      return Colors.blueGrey.shade900;
    }
  }
}
