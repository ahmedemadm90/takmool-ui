import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 100.h,
        width: 100.w,
        color: HexColor('003399'),
        child: Column(
          children: [
            Container(
              height: 20.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileCard(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ahmed Emad',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Web Developer',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  NotificationIcon(notificationCount: 2),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Logged In Duration',style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 37.h,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(

      radius: 28.sp,
      backgroundImage: AssetImage('assets/images/img.jpg'),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final int notificationCount;
  NotificationIcon({required this.notificationCount});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(
          IconlyBroken.notification,
          color: Colors.white,
          size: 30.sp,
        ),
        if (notificationCount > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                notificationCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
