import 'package:digital_clock/star_clock.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart';

class BackgroundController extends FlareController {
  static const double ANIMATION_SPEED_STARS_MOVING = 0.15;
  static const double ANIMATION_SPEED_STARS_SHOOTING = 0.65;

  ClockTheme _theme;
  BackgroundController(this._theme);

  double transitionTime = 0;
  double timeWeather = 0;

  FlutterActorArtboard _artboard;
  FlareAnimationLayer _animIdle;
  FlareAnimationLayer _animStarsMoving;
  FlareAnimationLayer _animStarsFlashing;
  FlareAnimationLayer _animStarsShooting;

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
    }

    // # Animate stars # //
    // Moving
    _animStarsMoving.time = (_animStarsMoving.time +
            (elapsed * BackgroundController.ANIMATION_SPEED_STARS_MOVING)) %
        _animStarsMoving.duration;
    _animStarsMoving.apply(artboard);

    // Flashing
    _animStarsFlashing.time =
        (_animStarsFlashing.time + elapsed) % _animStarsFlashing.duration;
    _animStarsFlashing.apply(artboard);

    // Shooting
    _animStarsShooting.time = (_animStarsShooting.time +
            (elapsed * BackgroundController.ANIMATION_SPEED_STARS_MOVING)) %
        _animStarsShooting.duration;
    _animStarsShooting.apply(artboard);

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

    _animStarsMoving = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("stars_moving")
      ..mix = 1.0;

    _animStarsFlashing = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("stars_flashing")
      ..mix = 1.0;

    _animStarsShooting = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("stars_shooting")
      ..mix = 1.0;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
