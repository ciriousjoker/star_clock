import 'dart:async';
import 'package:digital_clock/src/core/helpers/theme_helper.dart';
import 'package:digital_clock/src/ui/widgets/background_widget.dart';
import 'package:digital_clock/src/ui/widgets/time_widget.dart';
import 'package:digital_clock/src/ui/widgets/weather_hud_widget.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';

enum _Element {
  background,
  text,
  shadow,
}

enum ClockTheme { day, night }

final _lightTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Colors.red,
};

/// A basic digital clock.
///
/// You can do better than this!
class StarClock extends StatefulWidget {
  const StarClock(this.model);

  final ClockModel model;

  @override
  _StarClockState createState() => _StarClockState();
}

class _StarClockState extends State<StarClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  ClockTheme theme = ClockTheme.day;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(StarClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();

      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 2) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = getClockTheme(context);

    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    WeatherCondition weather = widget.model.weatherCondition;

    return Container(
      color: colors[_Element.background],
      child: Center(
        child: Stack(
          children: <Widget>[
            BackgroundWidget(
              theme: theme,
              weather: weather,
              dateTime: _dateTime,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: TimeWidget(
                    is24HourFormat: widget.model.is24HourFormat,
                    dateTime: _dateTime,
                    theme: theme,
                    weather: weather),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: WeatherHudWidget(
                  theme: theme,
                  model: widget.model,
                  dateTime: _dateTime,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
