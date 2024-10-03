import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime selectedDate = DateTime.now();
  bool hasData = true; // Boolean to determine if data exists for the month

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Date',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: HexColor('003399'),
            hintColor: Colors.white,
            dialogBackgroundColor: HexColor('E5EEFF'),
            colorScheme: ColorScheme.light(
              primary: HexColor('003399'),
              onPrimary: Colors.white,
              surface: HexColor('E5EEFF'),
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: HexColor('003399'),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        hasData = _checkDataForMonth(picked); // Check if data exists for the selected month
      });
    }
  }

  // Check if data exists for the selected month
  bool _checkDataForMonth(DateTime date) {
    // Mock logic: No data for October 2024 as an example
    if (date.year == 2024 && date.month == 10) {
      return false;
    }
    return true;
  }

  // Function to handle month navigation using the arrows
  void _changeMonth(int increment) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + increment);
      hasData = _checkDataForMonth(selectedDate); // Update data existence check
    });
  }

  // Generate the days of the selected month
  List<DateTime> _getDaysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return List.generate(lastDay.day, (index) => DateTime(date.year, date.month, index + 1));
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMMM yyyy').format(selectedDate);
    List<DateTime> daysInMonth = _getDaysInMonth(selectedDate); // Get all days in the selected month

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Attendance',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(IconlyBroken.arrowLeft, color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9),
            child: Row(
              children: [
                Image(image: AssetImage('assets/images/vector2.png')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.document), label: 'Request'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.setting), label: 'Setting'),
        ],
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => _changeMonth(-1), // Decrease month
              icon: Icon(IconlyBroken.arrowLeft2),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                children: [
                  Icon(IconlyBroken.calendar, color: HexColor('003399')),
                  SizedBox(width: 2.w),
                  Text(
                    formattedMonth,
                    style: TextStyle(color: HexColor('003399')),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _changeMonth(1), // Increase month
              icon: Icon(IconlyBroken.arrowRight2),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        // Show a "No data" container if there's no data for the selected month
        if (!hasData)
          Container(
            height: 60.h,
            alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(image: AssetImage('assets/images/no data.png')),
                  SizedBox(height: 1.h),
                  Text('You don’t have any attendance history yet'),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: Column(
              children: [
                // Table Header
                Container(
                  color: HexColor('E5EEFF'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: Center(child: Text('Day', style: TextStyle(fontWeight: FontWeight.bold)))),

                      Expanded(child: Center(child: Text('In', style: TextStyle(fontWeight: FontWeight.bold)))),

                      Expanded(child: Center(child: Text('Out', style: TextStyle(fontWeight: FontWeight.bold)))),

                      Expanded(child: Center(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                  ),
                  height: 5.h,
                ),

                // Expanded ListView for attendance rows
                Expanded(
                  child: ListView(
                    children: [
                      // Attendance Rows
                      for (var day in daysInMonth)
                        day.weekday == DateTime.friday
                            ? WeekendRow(day: day) // Custom widget for Fridays
                            : AttendanceRow(day: day),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
    );
  }
}

// Widget for Regular Attendance Rows

class AttendanceRow extends StatelessWidget {
  final DateTime day;
  final Random random = Random(); // Random instance

  AttendanceRow({required this.day});

  @override
  Widget build(BuildContext context) {
    // Randomly decide if the warning icon should be shown (for demonstration, 20% chance)
    bool showWarningIcon = random.nextBool(); // Use random logic to determine if warning icon should be shown

    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/rect.png'),
                      height: 5.h,
                    ),
                    Column(
                      children: [
                        Text(
                          DateFormat('EEE').format(day),
                          style: TextStyle(color: Colors.red),
                        ), // Day of the week
                        Text(day.day.toString()), // Day of the month
                      ],
                    )
                  ],
                ),
              ),
            ),
            Baseline(
              baselineType: TextBaseline.alphabetic,
              baseline: 3.7.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showWarningIcon // Check if warning icon should be displayed
                          ? Image(image: AssetImage('assets/images/warning.png')) // Warning icon
                          : Transform.rotate(
                        child: Icon(Icons.arrow_downward,
                            color: Colors.blue, size: 2.h),
                        angle: 21 / pi,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '08:00 am',
                        style: TextStyle(
                            color: Colors.green, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Baseline(
              baselineType: TextBaseline.alphabetic,
              baseline: 3.7.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showWarningIcon // Check if warning icon should be displayed
                          ? Image(image: AssetImage('assets/images/warning.png'))
                          : Transform.rotate(
                        child: Icon(Icons.arrow_downward,
                            color: Colors.blue, size: 2.h),
                        angle: -8 / pi,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '05:00 pm',
                        style: TextStyle(
                            color: Colors.black, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Baseline(
              baselineType: TextBaseline.alphabetic,
              baseline: 3.7.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '08:00 hrs',
                        style: TextStyle(
                            color: HexColor('F85640'), fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// Widget for Weekend (Friday) Rows
class WeekendRow extends StatelessWidget {
  final DateTime day;
  const WeekendRow({required this.day});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('FFE5E5'), // Special color for weekends
      child: Container(
        height: 6.h,
        width: 70.w,
        decoration: BoxDecoration(
          color: HexColor('FEF0C7'),
          borderRadius: BorderRadius.circular(50)
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Weekend : ', style: TextStyle(
                color: HexColor('9D5425')
              ),), // Day of the week
              
              Text(DateFormat('EEE').format(day),style: TextStyle(
                color: HexColor('9D5425')
              ),), // Day of the week
              SizedBox(width: 2.w,),
              Text(day.day.toString(),style: TextStyle(
                  color: HexColor('9D5425')
              )),
            ],
          ),
        ),
      ),
    );
  }
}
