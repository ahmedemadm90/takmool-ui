import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:takamool/requests/holidays_screen.dart';
import 'package:takamool/requests/loss_attendance_screen.dart';
import 'package:takamool/requests/my_requests_screen.dart';
import 'package:takamool/requests/sick_leave_screen.dart';

class RequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('F3F4F6'),
      appBar: AppBar(
        backgroundColor: HexColor('FBFBFB'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(IconlyBroken.arrowLeft2),
        ),
        title: Text(
          'Requests',
          style: TextStyle(fontFamily: 'cairo'),
        ),
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 95.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.h),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    // Optionally add error handling for navigation
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyRequestsScreen()),
                      );
                    } catch (error) {
                      // Handle any errors (optional)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Navigation error: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image for requests
                        Image(
                          image: AssetImage('assets/images/requests.png'),
                          width: 13.w,
                          // Add a semantic label for accessibility
                          semanticLabel: 'Requests Icon',
                        ),
                        SizedBox(height: 1.h),
                        // Text for "My Requests"
                        Text(
                          'My Requests',
                          style: TextStyle(
                            fontFamily: 'cairo',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Optionally, add a splash effect on tap
                  onTapDown: (_) {
                    // You can add any additional feedback here if needed
                  },
                ),

              ),
              SizedBox(height: 2.h),
              Container(
                width: 95.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text baselines
                  children: [
                    buildServiceBox(
                      'Loss Attendance',
                      'assets/images/clipboard.png',
                      context,
                      LossAttendanceScreen(),
                    ),
                    buildServiceBox(
                      'Holiday',
                      'assets/images/holiday.png',
                      context,
                      HolidayScreen(),
                    ),
                    buildServiceBox(
                      'Sick Leave',
                      'assets/images/dizziness.png',
                      context,
                      SickLeaveScreen(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildServiceBox(String title, String imagePath, BuildContext context, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: 30.w,
        height: 15.h, // Adjusted height for consistency
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 10.w,
            ),
            SizedBox(height: 1.h), // Space between image and text
            Text(
              title,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
