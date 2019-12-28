import 'package:digital_clock/src/core/extensions.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherHudWidget extends StatelessWidget {
  final ClockModel model;
  final ClockTheme theme;

  const WeatherHudWidget({Key key, this.theme, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.87,
      child: Container(
        margin: EdgeInsets.all(8),

        decoration: new BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            backgroundBlendMode: BlendMode.multiply,
            // boxShadow: kElevationToShadow[2],
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
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.temperatureString,
                    // textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    model.location,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // SvgPicture.network(
        //   'https://www.svgrepo.com/show/2046/dog.svg',
        //   placeholderBuilder: (context) => CircularProgressIndicator(),
        //   height: 128.0,
        // ),
      ),
    );
  }

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
        if (theme == ClockTheme.day) {
          weatherType = "sunny";
        } else {
          weatherType = "clear";
        }
        break;
      case WeatherCondition.thunderstorm:
        weatherType = "thunderstorm";
        break;
      case WeatherCondition.windy:
        if (theme == ClockTheme.day) {
          weatherType = "windy";
        } else {
          weatherType = "cloudy-windy";
        }
        break;
    }
    return 'third_party/weather-icons/svg/wi-${theme.toShortString()}-$weatherType.svg';
  }
}
