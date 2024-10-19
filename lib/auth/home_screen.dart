import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.document), label: 'Request'),
          BottomNavigationBarItem(icon: Icon(IconlyBold.setting), label: 'Setting'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            SizedBox(height: 4.h),
            buildLoggedInDurationCard(context),
            SizedBox(height: 4.h),
            Card(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.withOpacity(0.5), // Color of the shadow
                      spreadRadius: 2, // How far the shadow spreads
                      blurRadius: 5, // Blur effect of the shadow
                      offset:
                          Offset(0, 3), // Changes position of the shadow (x, y)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                      10), // Optional: adds rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Office Services',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildServiceBox('Attendance\nOverview', 'assets/images/calendar.png'),
                          SizedBox(width: 2.w,),
                          buildServiceBox('Holidays', 'assets/images/holiday.png'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      width: 100.w,
      height: 20.h,
      color: HexColor('003399'),
      child: Padding(
        padding: EdgeInsets.all(7.w),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/img.jpg'),
              radius: 6.w,
            ),
            SizedBox(width: 3.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ahmed Emad :)',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'UI/UX Designer',
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 16.sp,
                      color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            Container(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CircleAvatar(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 3.w, color: Colors.white),
                    ),
                    radius: 9,
                    backgroundColor: Colors.red,
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoggedInDurationCard(context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100.w,
            child: Text(
              'Logged In Duration',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: 80.w,
            height: 9.2.h,
            decoration: BoxDecoration(
                color: HexColor('F3F4F6'),
                borderRadius: BorderRadiusDirectional.circular(10)),
            // color: HexColor('F3F4F6'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeBox('05', 'HOUR'),
                SizedBox(width: 4.w),
                buildTimeBox(':', ''),
                SizedBox(width: 4.w),
                buildTimeBox('00', 'MIN'),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Check In',
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                Text(
                  'Check Out',
                  style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    '08:00 AM',
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: HexColor('00A650'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: HexColor('00A650').withOpacity(.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: Text(
                    '05:00 PM',
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: HexColor('F04438'),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: HexColor('F04438').withOpacity(.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          ElevatedButton(
            onPressed: () {
              DateTime now = DateTime.now();
              String formattedTime = formatTime(now);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsetsDirectional.only(
                      bottom: 85.h, start: 2.w, end: 2.w),
                  backgroundColor: Colors.green,
                  content: Text('Current Time: $formattedTime'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor('003399'),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.5.h),
            ),
            child: Text(
              'Check-in / Check-out',
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeBox(String time, String label) {
    return Container(
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Text(
            label,
            style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildCheckInOutRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Check In',
            style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
          Text(
            'Check Out',
            style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildCheckInOutColumn(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey),
        ),
        Text(
          time,
          style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ],
    );
  }

  Widget buildServiceBox(String title, String imagePath) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset('assets/images/rect.png'),
            Image.asset(imagePath,width: 15.w,),
          ],
        ),
        SizedBox(height: 2.h), // Space between image and text
        Text(
          title,
          style: TextStyle(
            fontFamily: 'cairo',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center, // Center the text
          maxLines: 2, // Restrict to two lines
          softWrap: true, // Enable text wrapping
        ),
      ],
    );
  }

  String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? "PM" : "AM";
    // Convert to 12-hour format
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Adjust for midnight (00:00 -> 12:00 AM)
    // Format minutes with two digits
    String formattedMinute = minute.toString().padLeft(2, '0');

    // Return formatted time as a string
    return "$hour:$formattedMinute $period";
  }
}
