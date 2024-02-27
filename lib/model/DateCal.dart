import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import '../Views/Home.dart';

class Date_CAl extends StatefulWidget {
  const Date_CAl({Key? key}) : super(key: key);

  @override
  _Date_CAlState createState() => _Date_CAlState();
}

class _Date_CAlState extends State<Date_CAl> {
  final DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateToDate(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: DatePicker(
        DateTime.utc(2024, 2, 1),
        controller: _controller,
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blueAccent,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          navigationController.setSelectedDate(date);
        },
      ),
    );
  }
}
