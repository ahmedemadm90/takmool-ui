import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:takamool/requests/holiday_sub_screens/all_reqs_screen.dart';
import 'package:takamool/requests/holiday_sub_screens/approved_screen.dart';
import 'package:takamool/requests/holiday_sub_screens/pending_screen.dart';
import 'package:takamool/requests/holiday_sub_screens/rejected_screen.dart';

class HolidayScreen extends StatefulWidget {
  @override
  _HolidayScreenState createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  DateTime selectedDate = DateTime.now();
  bool hasData = true;
  Widget activeScreen = AllReqsScreen();
  int selectedTab = 0; // Added variable to track the selected tab

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
        hasData = _checkDataForMonth(picked);
      });
    }
  }

  bool _checkDataForMonth(DateTime date) {
    if (date.year == 2024 && date.month == 10) {
      return false;
    }
    return true;
  }

  void _changeMonth(int increment) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + increment);
      hasData = _checkDataForMonth(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMMM yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Holidays',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconlyBroken.arrowLeft, color: Colors.black),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _changeMonth(-1),
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
                onPressed: () => _changeMonth(1),
                icon: Icon(IconlyBroken.arrowRight2),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                      activeScreen = AllReqsScreen();
                    });
                  },
                  child: Container(
                    width: 12.w,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: selectedTab == 0 ? HexColor('003399') : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                      activeScreen = ApprovedScreen(); // Replace with ApprovedReqsScreen if needed
                    });
                  },
                  child: Container(
                    width: 23.w,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          'Approved',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: selectedTab == 1 ? HexColor('003399') : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 2;
                      activeScreen = PendingScreen(); // Replace with PendingReqsScreen if needed
                    });
                  },
                  child: Container(
                    width: 23.w,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          'Pending',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: selectedTab == 2 ? HexColor('003399') : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 3;
                      activeScreen = RejectedScreen();
                    });
                  },
                  child: Container(
                    width: 23.w,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          'Rejected',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: selectedTab == 3 ? HexColor('003399') : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: activeScreen),
        ],
      ),
    );
  }
}
