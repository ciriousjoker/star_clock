import 'package:star_clock/src/core/flare_controllers/background_controller.dart';
import 'package:star_clock/star_clock.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:star_clock/src/core/extensions.dart';

class BackgroundWidget extends StatefulWidget {
  static const String ANIMATION_IDLE = "idle";

  final ClockTheme theme;
  final WeatherCondition weather;
  final DateTime dateTime;

  const BackgroundWidget(
      {Key key,
      @required this.theme,
      @required this.weather,
      @required this.dateTime})
      : super(key: key);

  @override
  _BackgroundWidgetState createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  BackgroundController _backgroundControllerDay;
  BackgroundController _backgroundControllerNight;

  @override
  void initState() {
    super.initState();
    _backgroundControllerDay =
        BackgroundController(ClockTheme.day, widget.dateTime);
    _backgroundControllerNight =
        BackgroundController(ClockTheme.night, widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    _backgroundControllerDay.dateTime = widget.dateTime;
    _backgroundControllerNight.dateTime = widget.dateTime;

    return Stack(children: <Widget>[
      Container(
        key: Key(widget.theme.toShortString()),
        child: FlareActor(
          "assets/background.flr",
          controller: widget.theme == ClockTheme.day
              ? _backgroundControllerDay
              : _backgroundControllerNight,
          sizeFromArtboard: false,
        ),
      ),
      widget.theme == ClockTheme.day &&
              widget.dateTime.hour >= 7 &&
              widget.dateTime.hour < 20
          ? Stack(
              children: getWeatherLayers(),
            )
          : Container()
    ]);
  }

  List<Widget> getWeatherLayers() {
    return <Widget>[
      // In case of thunderstorm: Add windy, rainy & cloudy as well (onlky bonus clouds for rainy)
      widget.weather == WeatherCondition.thunderstorm
          ? FlareActor(
              getWeatherFile("windy"),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: false,
            )
          : Container(),
      widget.weather == WeatherCondition.thunderstorm
          ? FlareActor(
              getWeatherFile("rainy"),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: false,
            )
          : Container(),
      widget.weather == WeatherCondition.thunderstorm ||
              widget.weather == WeatherCondition.rainy
          ? FlareActor(
              getWeatherFile("cloudy"),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: false,
            )
          : Container(),

      // Add main weather
      widget.weather != null
          ? FlareActor(
              getWeatherFile(widget.weather.toShortString()),
              animation: BackgroundWidget.ANIMATION_IDLE,
              sizeFromArtboard: false,
            )
          : Container(),
    ];
  }

  String getWeatherFile(String name) {
    return "assets/weather/$name.flr";
  }
}
