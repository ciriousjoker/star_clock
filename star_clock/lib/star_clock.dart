// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/src/core/flare_controllers/background_controller.dart';
import 'package:digital_clock/src/core/flare_controllers/cloud_controller.dart';
import 'package:digital_clock/src/core/helpers/theme_helper.dart';
import 'package:digital_clock/src/ui/widgets/time_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
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
  BackgroundController _backgroundControllerNight =
      BackgroundController(ClockTheme.night);
  BackgroundController _backgroundControllerDay =
      BackgroundController(ClockTheme.day);

  CloudController _cloudController = CloudController();
  ClockTheme theme = ClockTheme.night;

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
      // _timer = Timer(
      //   Duration(minutes: 1) -
      //       Duration(seconds: _dateTime.second) -
      //       Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 3) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = getClockTheme(context);

    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    WeatherCondition weather = widget.model.weatherCondition;

    // _backgroundControllerNight.theme = theme;
    // _backgroundControllerDay.theme = theme;

    return Container(
      color: colors[_Element.background],
      child: Center(
        child: Stack(
          children: <Widget>[
            // Positioned(left: offset, top: 0, child: Text(hour)),
            // Positioned(right: offset, bottom: offset, child: Text(minute)),
            theme == ClockTheme.day
                ? Container(
                    key: Key(theme.toShortString()),
                    child: FlareActor(
                      "assets/backgroundv2.flr",
                      controller: _backgroundControllerDay,
                      sizeFromArtboard: true,
                    ),
                  )
                : Container(
                    key: Key(theme.toShortString()),
                    child: FlareActor(
                      "assets/backgroundv2.flr",
                      controller: _backgroundControllerNight,
                      sizeFromArtboard: true,
                    ),
                  ),

            // Weather effects
            // NOTE: Only show weather if the theme is light
            theme == ClockTheme.day
                ? Stack(children: <Widget>[
                    weather == WeatherCondition.foggy
                        ? FlareActor(
                            "assets/foggy.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                    weather == WeatherCondition.rainy ||
                            weather == WeatherCondition.thunderstorm
                        ? FlareActor(
                            "assets/rainy.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                    weather == WeatherCondition.windy ||
                            weather == WeatherCondition.thunderstorm
                        ? FlareActor(
                            "assets/windy.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                    weather == WeatherCondition.sunny
                        ? FlareActor(
                            "assets/sunny.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                    weather == WeatherCondition.snowy
                        ? FlareActor(
                            "assets/snowy.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                    weather == WeatherCondition.cloudy
                        ? FlareActor(
                            "assets/cloudy.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                    weather == WeatherCondition.thunderstorm
                        ? FlareActor(
                            "assets/thunderstorm.flr",
                            animation: "idle",
                            sizeFromArtboard: true,
                          )
                        : Container(),
                  ])
                : Container(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 80),
                child: TimeWidget(
                    is24HourFormat: widget.model.is24HourFormat,
                    dateTime: _dateTime),
              ),
            )
          ],
        ),
      ),
    );
  }
}
