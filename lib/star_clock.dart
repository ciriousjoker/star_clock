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
import 'package:intl/intl.dart';

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
  BackgroundController _backgroundController = BackgroundController();
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

    final fontSize = MediaQuery.of(context).size.width / 3.5;

    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'PressStart2P',
      fontSize: fontSize,
      shadows: [
        Shadow(
          blurRadius: 0,
          color: colors[_Element.shadow],
          offset: Offset(10, 0),
        ),
      ],
    );

    _backgroundController.theme = theme;

    return Container(
      color: colors[_Element.background],
      child: Center(
        child: DefaultTextStyle(
          style: defaultStyle,
          child: Stack(
            children: <Widget>[
              // Positioned(left: offset, top: 0, child: Text(hour)),
              // Positioned(right: offset, bottom: offset, child: Text(minute)),
              FlareActor(
                "assets/background.flr",
                controller: _backgroundController,
                sizeFromArtboard: true,
              ),
              FlareActor(
                "assets/clouds.flr",
                controller: _cloudController,
                color: theme == ClockTheme.day
                    ? Colors.blue.shade300
                    : Colors.white,
                sizeFromArtboard: true,
              ),
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
      ),
    );
  }
}
