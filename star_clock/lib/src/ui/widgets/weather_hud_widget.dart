import 'package:star_clock/src/core/helpers/state_helper.dart';
import 'package:star_clock/star_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherHudWidget extends StatelessWidget {
  final ClockModel model;
  final ClockTheme theme;
  final DateTime dateTime;

  const WeatherHudWidget(
      {Key key,
      @required this.theme,
      @required this.model,
      @required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorBackground = isDark(theme, dateTime, model.weatherCondition)
        ? Colors.black.withOpacity(0.2)
        : Colors.white.withOpacity(0.2);
    Color colorForeground = isDark(theme, dateTime, model.weatherCondition)
        ? Colors.white
        : Colors.black;

    return Opacity(
      opacity: 0.87,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: new BoxDecoration(
            color: colorBackground,
            backgroundBlendMode: BlendMode.multiply,
            borderRadius: new BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                getWeatherAsset(),
                placeholderBuilder: (context) => CircularProgressIndicator(),
                height: 32.0,
                color: colorForeground,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.temperatureString,
                    style: TextStyle(
                      color: colorForeground,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    model.location,
                    style: TextStyle(
                      color: colorForeground,
                      fontSize: 8,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Translates the weather & theme into a svg asset icon name
  String getWeatherAsset() {
    String weatherType = "";
    switch (model.weatherCondition) {
      case WeatherCondition.cloudy:
        weatherType = "cloudy";
        break;
      case WeatherCondition.snowy:
        weatherType = "snow";
        break;
      case WeatherCondition.foggy:
        weatherType = "fog";
        break;
      case WeatherCondition.rainy:
        weatherType = "rain";
        break;
      case WeatherCondition.sunny:
        if (isDarkProxy()) {
          weatherType = "clear";
        } else {
          weatherType = "sunny";
        }
        break;
      case WeatherCondition.thunderstorm:
        weatherType = "thunderstorm";
        break;
      case WeatherCondition.windy:
        if (isDarkProxy()) {
          weatherType = "cloudy-windy";
        } else {
          weatherType = "windy";
        }
        break;
    }
    return 'third_party/weather-icons/svg/wi-${getDayOrNightString()}-$weatherType.svg';
  }

  String getDayOrNightString() {
    if (isDarkProxy()) {
      return "night";
    } else {
      return "day";
    }
  }

  bool isDarkProxy() => isDark(theme, dateTime, model.weatherCondition);
}
