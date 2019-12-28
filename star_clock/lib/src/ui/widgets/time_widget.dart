import 'package:digital_clock/src/ui/widgets/digit_widget.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

class TimeWidget extends StatefulWidget {
  static const double SCALE = 1.1;

  final bool is24HourFormat;
  final ClockTheme theme;
  final WeatherCondition weather;

  final DateTime dateTime;
  TimeWidget(
      {Key key, this.is24HourFormat, this.dateTime, this.theme, this.weather})
      : super(key: key);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  List<int> digits;

  @override
  Widget build(BuildContext context) {
    List<int> digitsPrevious = digits;
    digits = getDigits();

    return Container(
      // color: Colors.green,
      // child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: getDigitWidgets(digitsPrevious, digits),
      ),
      // ),
    );
  }

  List<int> getDigits() {
    List<int> digits = List();

    final hour =
        DateFormat(widget.is24HourFormat ? 'HH' : 'hh').format(widget.dateTime);
    final minute = DateFormat('mm').format(widget.dateTime);
    // final second = DateFormat('ss').format(widget.dateTime);

    digits.add(int.parse(hour.substring(0, 1)));
    digits.add(int.parse(hour.substring(1, 2)));

    // Divider
    digits.add(-1);

    digits.add(int.parse(minute.substring(0, 1)));
    digits.add(int.parse(minute.substring(1, 2)));

    // // Seconds
    // print("Seconds: " + second);
    // digits.add(int.parse(second.substring(0, 1)));
    // digits.add(int.parse(second.substring(1, 2)));
    return digits;
  }

  List<Widget> getDigitWidgets(List<int> digitsPrevious, List<int> digits) {
    // for(int i = 0; i < digits)

    List<Widget> ret = new List();

    digits.asMap().forEach((index, value) {
      ret.add(Container(
        constraints: BoxConstraints(
            maxWidth: 50 * TimeWidget.SCALE,
            maxHeight: DigitWidget.MAX_WIDTH * TimeWidget.SCALE),
        child: OverflowBox(
          maxWidth: DigitWidget.MAX_WIDTH * TimeWidget.SCALE,
          maxHeight: DigitWidget.MAX_WIDTH * TimeWidget.SCALE,
          child: DigitWidget(
            position: index,
            digit: value,
            scale: TimeWidget.SCALE,
            theme: widget.theme,
            weather: widget.weather,
          ),
        ),
      ));
    });

    // var test = digits.map((digit) {
    //   return
    //       // IntrinsicHeight(
    //       // child:
    //       Container(
    //     // color: Colors.yellow,
    //     constraints: BoxConstraints(maxWidth: 50, maxHeight: 130),
    //     child: OverflowBox(
    //       maxWidth: 130,
    //       maxHeight: 130,

    //       // margin: EdgeInsets.all(-10),
    //       child: DigitWidget(digit: digit),
    //     ),
    //     // ),
    //   );
    // }).toList();
    return ret;
    // return [
    //   // Text("0:0")
    //   Container(
    //     constraints: BoxConstraints(maxHeight: 100),
    //     child: FlareActor(
    //       "assets/number_0.flr",
    //       animation: "idle",
    //       fit: BoxFit.scaleDown,
    //       sizeFromArtboard: true,
    //       // boundsNode: "Stars",
    //       // shouldClip: true,
    //     ),
    //   ),
    // ];
  }
}
