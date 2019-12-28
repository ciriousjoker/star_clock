import 'package:digital_clock/src/core/flare_controllers/background_controller.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:digital_clock/src/core/extensions.dart';

class BackgroundWidget extends StatefulWidget {
  static const String ANIMATION_IDLE = "idle";

  final ClockTheme theme;
  final WeatherCondition weather;

  const BackgroundWidget({Key key, this.theme, this.weather}) : super(key: key);

  @override
  _BackgroundWidgetState createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  BackgroundController _backgroundControllerNight =
      BackgroundController(ClockTheme.night);

  BackgroundController _backgroundControllerDay =
      BackgroundController(ClockTheme.day);

  @override
  Widget build(BuildContext context) {
    // List<Widget> layers = getWeatherLayers();
    return Stack(children: <Widget>[
      Container(
        key: Key(widget.theme.toShortString()),
        child: FlareActor(
          "assets/background.flr",
          controller: widget.theme == ClockTheme.day
              ? _backgroundControllerDay
              : _backgroundControllerNight,
          sizeFromArtboard: true,
        ),
      ),
      widget.theme == ClockTheme.day &&
              DateTime.now().hour >= 7 &&
              DateTime.now().hour < 20
          ? Stack(
              children: getWeatherLayers(),
            )
          : Container()
    ]);
  }

  List<Widget> getWeatherLayers() {
    return <Widget>[
      // In case of thunderstorm: Add windy, rainy & cloudy as well
      widget.weather == WeatherCondition.thunderstorm
          ? FlareActor(
              getWeatherFile("windy"),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: true,
            )
          : Container(),
      widget.weather == WeatherCondition.thunderstorm
          ? FlareActor(
              getWeatherFile("rainy"),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: true,
            )
          : Container(),
      widget.weather == WeatherCondition.thunderstorm ||
              widget.weather == WeatherCondition.rainy
          ? FlareActor(
              getWeatherFile("cloudy"),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: true,
            )
          : Container(),

      // Add main weather
      widget.weather != null
          ? FlareActor(
              getWeatherFile(widget.weather.toShortString()),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: true,
            )
          : Container(),
    ];
  }

  String getWeatherFile(String name) {
    return "assets/weather/$name.flr";
  }
}
