import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: Icon(IconlyBroken.arrowLeft2)),
              Row(
                children: [
                  Icon(
                    IconlyBroken.calendar,
                    color: HexColor('003399'),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'December 2024',
                    style: TextStyle(color: HexColor('003399')),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(IconlyBroken.arrowRight2)),
            ],
          ),
          SizedBox(height: 2.h),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: HexColor('E5EEFF')),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Check In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Check Out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'HRS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 900,
              itemBuilder: (context, index) {
                // Check if the index is every 6th row (starting from 6)
                if (index % 6 == 0 && index != 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 7.h,
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'weekend : 03 friday ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: HexColor('9D5425'),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: HexColor('FEF0C7'),
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(8))
                      ),
                    ),
                  );
                }

                // Normal row data
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
                                    child: Icon(Icons.arrow_downward,
                                        color: Colors.blue, size: 2.h),
                                    angle: 2 / pi),
                                SizedBox(width: 1.w),
                                Text(
                                  '09:15 am',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 13.sp),
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
                                  child: Icon(Icons.arrow_downward,
                                      color: Colors.blue, size: 2.h),
                                  angle: -8 / pi,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  '06:00 pm',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13.sp),
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
