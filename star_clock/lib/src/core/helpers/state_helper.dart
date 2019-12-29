import 'package:star_clock/star_clock.dart';
import 'package:flutter_clock_helper/model.dart';

bool isDark(ClockTheme theme, DateTime dateTime, WeatherCondition weather) {
  if (theme == ClockTheme.night) {
    return true;
  }

  // Weather exceptions
  if (weather == WeatherCondition.thunderstorm ||
      weather == WeatherCondition.rainy ||
      weather == WeatherCondition.cloudy) {
    return true;
  }

  if (weather == WeatherCondition.foggy) {
    return false;
  }

  // Default color for day/night
  if (dateTime.hour < 11 || dateTime.hour >= 16) {
    return true;
  } else {
    return false;
  }
}
