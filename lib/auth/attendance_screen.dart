import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'dart:math'; // For generating random rows

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
    // Mock logic: No data for February 2024 as an example
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

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMMM yyyy').format(selectedDate);
    Random random = Random();
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
              height: 70.h,
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(image: AssetImage('assets/images/no data.png')),
                    SizedBox(height: 1.h,),
                    Text('You Don’t have any attendace history yet'),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index == random.nextInt(10)) {
                    return Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image(image: AssetImage('assets/images/icon 4.png')),
                                    Column(
                                      children: [
                                        Text(
                                          'Mon',
                                          style: TextStyle(
                                            color: HexColor('FE3C3B'),
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          '31',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Baseline(
                                baseline: 29.0,
                                baselineType: TextBaseline.alphabetic,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, color: Colors.red, size: 2.h),
                                    SizedBox(width: 1.w),
                                    Text(
                                      '09:15 am',
                                      style: TextStyle(color: Colors.red, fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Baseline(
                                baseline: 29.0,
                                baselineType: TextBaseline.alphabetic,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                      child: Icon(Icons.arrow_downward, color: Colors.blue, size: 2.h),
                                      angle: -8 / 3.14159,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      '06:00 pm',
                                      style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Baseline(
                                baseline: 29.0,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  '06:00 hrs',
                                  style: TextStyle(color: Colors.red, fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  // Regular attendance row
                  return Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image(image: AssetImage('assets/images/icon 4.png')),
                                  Column(
                                    children: [
                                      Text(
                                        'Mon',
                                        style: TextStyle(
                                          color: HexColor('FE3C3B'),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        '31',
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Baseline(
                              baseline: 29.0,
                              baselineType: TextBaseline.alphabetic,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                    child: Icon(Icons.arrow_downward, color: Colors.blue, size: 2.h),
                                    angle: 2 / 3.14159,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    '09:15 am',
                                    style: TextStyle(color: Colors.green, fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Baseline(
                              baseline: 29.0,
                              baselineType: TextBaseline.alphabetic,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                    child: Icon(Icons.arrow_downward, color: Colors.blue, size: 2.h),
                                    angle: -8 / 3.14159,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    '06:00 pm',
                                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Baseline(
                              baseline: 29.0,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(
                                '06:00 hrs',
                                style: TextStyle(color: Colors.red, fontSize: 13.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
