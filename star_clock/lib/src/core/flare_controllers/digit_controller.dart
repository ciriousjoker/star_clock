import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart';

class DigitController extends FlareController {
  static const String ANIMATION_ENTRY = "entry";
  static const String ANIMATION_IDLE = "idle";
  static const String ANIMATION_EXIT = "exit";

  final double _mix = 1.0;

  bool _looping = false;
  bool _exit = false;

  double _duration = 0.0;
  ActorAnimation _startAnimation;
  ActorAnimation _loopAnimation;
  ActorAnimation _exitAnimation;

  @override
  void initialize(FlutterActorArtboard artboard) {
    print("DigitController initialize()");
    _startAnimation = artboard.getAnimation(ANIMATION_ENTRY);
    _loopAnimation = artboard.getAnimation(ANIMATION_IDLE);

    _exitAnimation = artboard.getAnimation(ANIMATION_EXIT);

    _looping = false;
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _duration += elapsed;

    if (_exit) {
      _exitAnimation.apply(_duration, artboard, _mix);
      return true;
    }

    if (!_looping) {
      if (_duration < _startAnimation.duration) {
        _startAnimation.apply(_duration, artboard, _mix);
      } else {
        _looping = true;
        _duration -= _startAnimation.duration;
      }
    }
    if (_looping) {
      _duration %= _loopAnimation.duration;
      _loopAnimation.apply(_duration, artboard, _mix);
    }

    return true;
  }

  exit() {
    print("Controller: exit()");
    _exit = true;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
