import 'dart:developer';

import 'package:digital_clock/src/core/helpers/theme_helper.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flutter_clock_helper/model.dart';

class BackgroundController extends FlareController {
  static const double DemoMixSpeed = 10;
  static const double FPS = 60;
  static const double TRANSITION_DURATION = 5;

  ClockTheme _theme;
  BackgroundController(this._theme);

  double transitionTime = 0;
  double timeWeather = 0;

  // bool isDemoMode = true;
  // WeatherCondition _weather = WeatherCondition.sunny;

  FlutterActorArtboard _artboard;
  FlareAnimationLayer _animIdle;
  FlareAnimationLayer _animStars;
  // FlareAnimationLayer _animWeatherTransition;
  // FlareAnimationLayer _animWeatherIdle;

  // FlareAnimationLayer _animTransition;
  // final List<FlareAnimationLayer> _animsThemeTransitions = [];

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    // Background idle animation throughout the day
    DateTime date = DateTime.now();

    if (_animIdle != null) {
      int secondsPassed = date.hour * 60 * 60 + date.minute * 60 + date.second;
      int secondsTotal = 24 * 60 * 60;
      double animPercentage = (secondsPassed / secondsTotal).toDouble();
      _animIdle.time = animPercentage * 24;
      _animIdle.apply(artboard);

      // Stars are always moving, even if not visible
      _animStars.time = (_animStars.time + elapsed) % _animStars.duration;
      _animStars.apply(artboard);
    }

    // // All the idle weather animations
    // if (_animWeatherIdle != null) {
    //   timeWeather += elapsed;
    //   _animWeatherIdle.time = timeWeather % _animWeatherIdle.duration;
    //   _animWeatherIdle.mix = 1.0;
    //   _animWeatherIdle.apply(artboard);
    // }

    // if (_animWeatherTransition != null) {
    //   // print("Transition time: " + transitionTime.toString());
    //   _animWeatherTransition.time = transitionTime;
    //   transitionTime = (transitionTime + elapsed);
    //   _animWeatherTransition.mix = transitionTime / TRANSITION_DURATION;

    //   _animWeatherTransition.apply(artboard);

    //   // Move transition to idle
    //   if (transitionTime >= TRANSITION_DURATION) {
    //     transitionTime = 0;
    //     _animWeatherTransition = null;
    //   }
    // }

    // if (_animTransition != null) {
    //   // _animSnow.time = (_animSnow.time + elapsed) % _animSnow.duration;
    //   // _animSnow.apply(artboard);

    //   // _animTransition.time = transitionTime / TRANSITION_DURATION;
    //   _animTransition.apply(artboard);
    // }

    // // /// Iterate from the top b/c elements might be removed.
    // for (var layer in _animsThemeTransitions) {
    //   transitionTime = (transitionTime + elapsed) % TRANSITION_DURATION;
    //   layer.time = transitionTime;
    //   layer.mix = 1.0;
    //   layer.apply(artboard);

    //   /// When done, remove it.
    //   if (layer.isDone) {
    //     _animsThemeTransitions.remove(layer);
    //   }
    // }

    // /// If the app is still in demo mode, the mix is positive
    // /// Otherwise quickly ramp it down to stop the animation.
    // double demoMix =
    //     _animMovingStars.mix + DemoMixSpeed * (isDemoMode ? elapsed : -elapsed);
    // demoMix = demoMix.clamp(0.0, 1.0);
    // _animMovingStars.mix = demoMix;

    // if (demoMix != 0.0) {
    //   /// Advance the time, and loop.
    //   _animMovingStars.time =
    //       (_animMovingStars.time + elapsed) % _animMovingStars.duration;
    //   _animMovingStars.apply(artboard);
    //   /// Check which number of rooms is currently visible.
    //   _checkRoom();
    // }

    return true;
  }

  /// Grab the references to the right animations, and
  /// packs them into [FlareAnimationLayer] objects
  @override
  void initialize(FlutterActorArtboard artboard) {
    _artboard = artboard;

    if (_theme == ClockTheme.day) {
      _animIdle = FlareAnimationLayer()
        ..animation = _artboard.getAnimation("day_night")
        ..mix = 1.0;
    } else {
      _animIdle = FlareAnimationLayer()
        ..animation = _artboard.getAnimation("night_only")
        ..mix = 1.0;
    }

    _animStars = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("stars_moving")
      ..mix = 1.0;

    // _animWeatherIdle = FlareAnimationLayer()
    //   ..animation = _artboard.getAnimation("weather_idle")
    //   ..mix = 1.0;
  }

  // _changeWeather(WeatherCondition name) {
  //   if (name == null) {
  //     transitionTime = 0;
  //     _animWeatherTransition = null;
  //   }

  //   if (_artboard == null) {
  //     return;
  //   }

  //   ActorAnimation animation = _artboard.getAnimation(name.toShortString());
  //   if (animation != null) {
  //     transitionTime = 0;
  //     // _animsThemeTransitions.add(FlareAnimationLayer()..animation = animation);
  //     // _animTransition = FlareAnimationLayer()..animation = animation;

  //     _animWeatherTransition = FlareAnimationLayer()..animation = animation;
  //   }
  // }

  // set theme(ClockTheme theme) {
  //   if (_theme != theme) {
  //     print("Theme: " + theme.toShortString());
  //     _theme = theme;

  //     if (theme == ClockTheme.day) {
  //       _animIdle = FlareAnimationLayer()
  //         ..animation = _artboard.getAnimation("day_night")
  //         ..mix = 1.0;
  //     } else {
  //       _animIdle = FlareAnimationLayer()
  //         ..animation = _artboard.getAnimation("night_only")
  //         ..mix = 1.0;
  //     }
  //   }
  // }

  // int get rooms => _rooms;

  @override
  void setViewTransform(Mat2D viewTransform) {}
}

extension ParseToString on ClockTheme {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
