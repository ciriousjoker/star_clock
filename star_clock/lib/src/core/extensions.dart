import 'package:star_clock/star_clock.dart';
import 'package:flutter_clock_helper/model.dart';

extension ParseClockThemeToString on ClockTheme {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

extension ParseWeatherConditionToString on WeatherCondition {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
