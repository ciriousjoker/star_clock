import 'dart:developer';

import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart';

class BackgroundController extends FlareController {
  static const double DemoMixSpeed = 10;
  static const double FPS = 60;

  BackgroundController();

  // bool isDemoMode = true;
  ClockTheme _theme = ClockTheme.night;
  // double _lastDemoValue = 0.0;

  FlutterActorArtboard _artboard;
  FlareAnimationLayer _animMovingStars;
  FlareAnimationLayer _animMovingWaves;

  final List<FlareAnimationLayer> _animsThemeTransitions = [];

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    /// Advance the background animation every frame.
    _animMovingStars.time =
        (_animMovingStars.time + elapsed) % _animMovingStars.duration;
    _animMovingStars.apply(artboard);

    _animMovingWaves.time =
        (_animMovingWaves.time + elapsed) % _animMovingWaves.duration;
    _animMovingWaves.apply(artboard);

    // /// Iterate from the top b/c elements might be removed.
    for (var layer in _animsThemeTransitions) {
      layer.time += elapsed;
      layer.mix = 1.0;
      layer.apply(artboard);

      /// When done, remove it.
      if (layer.isDone) {
        _animsThemeTransitions.remove(layer);
      }
    }

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
    _animMovingStars = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("stars_moving")
      ..mix = 1.0;
    _animMovingWaves = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("waves_moving")
      ..mix = 1.0;

    // ActorAnimation endAnimation = artboard.getAnimation("to 6");
    // if (endAnimation != null) {
    //   endAnimation.apply(endAnimation.duration, artboard, 1.0);
    // }
  }

  _enqueueAnimation(String name) {
    ActorAnimation animation = _artboard.getAnimation(name);
    if (animation != null) {
      _animsThemeTransitions.add(FlareAnimationLayer()..animation = animation);
    }
  }

  set theme(ClockTheme theme) {
    if (_theme == theme) {
      return;
    }

    /// Sanity check.
    if (_artboard != null) {
      if (theme == ClockTheme.day) {
        _enqueueAnimation("transition_night_day");
      } else {
        _enqueueAnimation("transition_day_night");
        log("TODO: Implement");
      }
      _theme = theme;
    }
  }

  // int get rooms => _rooms;

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
