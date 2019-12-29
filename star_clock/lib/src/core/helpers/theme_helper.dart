import 'package:star_clock/star_clock.dart';
import 'package:flutter/material.dart';

getClockTheme(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light
        ? ClockTheme.day
        : ClockTheme.night;
