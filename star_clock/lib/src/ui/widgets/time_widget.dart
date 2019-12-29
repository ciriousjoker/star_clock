import 'package:digital_clock/src/ui/widgets/digit_widget.dart';
import 'package:digital_clock/star_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

class TimeWidget extends StatefulWidget {
  static const double SCALE = 2.0;
  static const double SPACE_PERCENTAGE = 0.75;
  static const double COLON_PERCENTAGE = 0.5;

  final bool is24HourFormat;
  final ClockTheme theme;
  final WeatherCondition weather;

  final DateTime dateTime;
  TimeWidget({
    Key key,
    @required this.is24HourFormat,
    @required this.dateTime,
    @required this.theme,
    @required this.weather,
  }) : super(key: key);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  List<int> digits;

  @override
  Widget build(BuildContext context) {
    List<int> digitsPrevious = digits;
    digits = getDigits();

    double widthTotal = getActualWidth(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: getDigitWidgets(digitsPrevious, digits, widthTotal),
      ),
    );
  }

  List<int> getDigits() {
    List<int> digits = List();

    final hour =
        DateFormat(widget.is24HourFormat ? 'HH' : 'hh').format(widget.dateTime);
    final minute = DateFormat('mm').format(widget.dateTime);

    digits.add(int.parse(hour.substring(0, 1)));
    digits.add(int.parse(hour.substring(1, 2)));

    // Divider
    digits.add(-1);

    digits.add(int.parse(minute.substring(0, 1)));
    digits.add(int.parse(minute.substring(1, 2)));

    // // Seconds
    // digits.add(-1);
    // print("Seconds: " + second);
    // digits.add(int.parse(second.substring(0, 1)));
    // digits.add(int.parse(second.substring(1, 2)));
    return digits;
  }

  List<Widget> getDigitWidgets(
      List<int> digitsPrevious, List<int> digits, double widthTotal) {
    List<Widget> ret = new List();

    double widthPerDigit = TimeWidget.SPACE_PERCENTAGE *
        widthTotal /
        (digits.length - TimeWidget.COLON_PERCENTAGE);

    digits.asMap().forEach((index, value) {
      ret.add(Container(
        constraints: BoxConstraints(
          maxWidth: value != -1
              ? widthPerDigit
              : widthPerDigit * TimeWidget.COLON_PERCENTAGE,
        ),
        child: OverflowBox(
          maxWidth: widthPerDigit * TimeWidget.SCALE,
          maxHeight: widthPerDigit * TimeWidget.SCALE,
          child: DigitWidget(
            position: index,
            digit: value,
            theme: widget.theme,
            weather: widget.weather,
            dateTime: widget.dateTime,
          ),
        ),
      ));
    });

    return ret;
  }

  double getActualWidth(BuildContext context) {
    double retWidthTotal = MediaQuery.of(context).size.width;

    // Extra code when running this on android to have a consistent size
    // TODO: Disable when building for an actual device
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      double statusBarHeight = 30.0;
      double aspectRatio = 5 / 3;
      retWidthTotal =
          (aspectRatio * (MediaQuery.of(context).size.height - statusBarHeight))
              .floorToDouble();
    }

    return retWidthTotal;
  }
}
