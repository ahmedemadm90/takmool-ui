import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:takamool/requests/holiday_sub_screens/show_request_data.dart';

class AllReqsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  width: 93.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      color: HexColor('0C3E9F')),
                ),
                Container(
                  width: 93.w,
                  height: 11.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      color: HexColor('E5EEFF')),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Holidays',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'cairo',
                              color: HexColor('0C3E9F')),
                        ),
                        Text(
                          '10 / 20',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'cairo',
                              fontWeight: FontWeight.bold,
                              color: HexColor('0C3E9F')),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            HolidayCard(
              startDate: DateTime(2024, 11, 15),
              endDate: DateTime(2024, 11, 18),
              status: 'Approved',
              TotalDays: '3 Days',
              toOperationScreen: () => _navigateToOperationScreen(context,
                  DateTime(2024, 11, 15), DateTime(2024, 11, 18), 'Approved'),
            ),
            HolidayCard(
              startDate: DateTime(2024, 11, 15),
              endDate: DateTime(2024, 11, 18),
              status: 'Pending',
              TotalDays: '3 Days',
              toOperationScreen: () => _navigateToOperationScreen(context,
                  DateTime(2024, 11, 15), DateTime(2024, 11, 18), 'Pending'),
            ),
            HolidayCard(
              startDate: DateTime(2024, 11, 21),
              endDate: DateTime(2024, 11, 23),
              status: 'Rejected',
              TotalDays: '3 Days',
              toOperationScreen: () => _navigateToOperationScreen(context,
                  DateTime(2024, 11, 21), DateTime(2024, 11, 23), 'Rejected'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToOperationScreen(
    BuildContext context,
    DateTime startDate,
    DateTime endDate,
    String status,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperationScreen(
          initialStartDate: startDate,
          initialEndDate: endDate,
          status: status,
        ),
      ),
    );
  }
}

class HolidayCard extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String TotalDays;
  final VoidCallback toOperationScreen;

  HolidayCard({
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.TotalDays,
    required this.toOperationScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 2.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.w),
                  bottomLeft: Radius.circular(2.w)),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              DateFormat('MMM dd, yyyy').format(startDate),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(' - '),
                            Text(
                              DateFormat('MMM dd, yyyy').format(endDate),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 20, color: Colors.grey[300]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          TotalDays,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    _getStatusIcons(status),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _getStatusIcons(String status) {
    switch (status) {
      case 'Approved':
        return IconButton(
          icon: Icon(
            IconlyBroken.document,
            size: 5.w,
          ),
          onPressed: () {
            print("Approved icon clicked");
            toOperationScreen();
          },
        );
      case 'Pending':
        return Row(
          children: [
            IconButton(
              icon: Icon(
                IconlyBroken.document,
                size: 5.w,
              ),
              onPressed: toOperationScreen,
            ),
          ],
        );
      case 'Rejected':
        return Row(
          children: [
            IconButton(
              icon: Icon(
                IconlyBroken.document,
                size: 5.w,
              ),
              onPressed: () {
                print("Document icon clicked");
                toOperationScreen();
              },
            ),
          ],
        );
      default:
        return Icon(
          Icons.help_outline,
          color: Colors.grey,
          size: 24,
        );
    }
  }
}
