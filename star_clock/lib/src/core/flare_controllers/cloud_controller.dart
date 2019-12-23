import 'dart:developer';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart';

class CloudController extends FlareController {
  static const double SPEEDFACTOR = 2;
  static const double FPS = 60;

  FlutterActorArtboard _artboard;
  FlareAnimationLayer _animCloudsSlow;
  FlareAnimationLayer _animCloudsFast;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    /// Advance the background animation every frame.
    _animCloudsSlow.time = (_animCloudsSlow.time + SPEEDFACTOR * elapsed) %
        _animCloudsSlow.duration;
    _animCloudsSlow.apply(artboard);

    _animCloudsFast.time = (_animCloudsFast.time + SPEEDFACTOR * elapsed) %
        _animCloudsFast.duration;
    _animCloudsFast.apply(artboard);
    return true;
  }

  /// Grab the references to the right animations, and
  /// packs them into [FlareAnimationLayer] objects
  @override
  void initialize(FlutterActorArtboard artboard) {
    _artboard = artboard;
    _animCloudsSlow = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("clouds_moving_slow")
      ..mix = 1.0;
    _animCloudsFast = FlareAnimationLayer()
      ..animation = _artboard.getAnimation("clouds_moving_fast")
      ..mix = 1.0;
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
