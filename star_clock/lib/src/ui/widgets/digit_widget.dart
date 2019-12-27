import 'package:digital_clock/src/core/flare_controllers/digit_controller.dart';
import 'package:digital_clock/src/ui/widgets/digit_layer.dart';
import 'package:flutter/material.dart';

class DigitWidget extends StatefulWidget {
  static const String ANIMATION_ENTRY = "entry";
  static const String ANIMATION_IDLE = "idle";
  static const String ANIMATION_EXIT = "exit";

  static const int MAX_WIDTH = 130;

  /// This is necessary to get unique keys to rebuild the widget
  final int position;

  /// Set to -1 to display a colon
  final int digit;

  final double scale;

  const DigitWidget({Key key, this.digit, this.position, this.scale = 1.0})
      : super(key: key);

  @override
  _DigitWidgetState createState() => _DigitWidgetState();
}

class _DigitWidgetState extends State<DigitWidget> {
  bool active = true;
  List<DigitController> digitController = [
    DigitController(),
    DigitController()
  ];

  bool isTransitioning = false;
  List<int> digits = [0, 0];

  List<String> animation = ["idle", "idle"];

  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldRebuild = widget.digit != digits[getLayer(active)];
    if (shouldRebuild) {
      digits[getLayer(!active)] = digits[getLayer(active)];
      digits[getLayer(active)] = widget.digit;

      animation[getLayer(active)] = DigitWidget.ANIMATION_ENTRY;
      animation[getLayer(!active)] = DigitWidget.ANIMATION_EXIT;
      counter++;
    }

    var ret = Container(
        key: Key("DigitContainer_${widget.position}_$counter"),
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: DigitWidget.MAX_WIDTH * widget.scale),
              child: getAnimationLayer(0),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: DigitWidget.MAX_WIDTH * widget.scale),
              child: getAnimationLayer(1),
            ),
          ],
        ));

    // key: Key("${++counter}"),
    // if (shouldRebuild) {
    //   ret.key = Key("${++counter}");
    // }

    return ret;
  }

  Widget getAnimationLayer(int layer) {
    int digit = digits[layer];

    if (digit == null) {
      print("Digit is null");
      digit = 404;
    }

    return DigitLayer(animation: animation[layer], digit: digit);
  }

  int getLayer(topIsActive) {
    return topIsActive ? 1 : 0;
  }

  String getDigitString(int digitOld) {
    String digitString = digitOld.toString();
    return digitString;
  }

  bool notNull(Object o) => o != null;
}
