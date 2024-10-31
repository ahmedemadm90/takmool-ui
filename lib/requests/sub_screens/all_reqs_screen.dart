import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:takamool/requests/sub_screens/show_request_data.dart';

class AllReqsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AttendanceCard(
              date: DateTime(2024, 4, 15),
              status: 'Approved',
              type: 'Loss attendance',
              onDelete: () => _showRequestDeleteDialog(context),
              onEdit: () => _navigateToOperationScreen(context, DateTime(2024, 4, 15), 'Approved', 'Leave In'),
            ),
            AttendanceCard(
              date: DateTime(2024, 5, 10),
              status: 'Pending',
              type: 'Sick leave',
              onDelete: () => _showRequestDeleteDialog(context),
              onEdit: () => _navigateToOperationScreen(context, DateTime(2024, 5, 10), 'Pending', 'Leave In'),
            ),
            AttendanceCard(
              date: DateTime(2024, 6, 25),
              status: 'Rejected',
              type: 'Holiday request',
              onDelete: () => _showRequestDeleteDialog(context),
              onEdit: () => _navigateToOperationScreen(context, DateTime(2024, 6, 25), 'Rejected', 'Leave In'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRequestDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.grey.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
                Text(
                  'Delete Request ?',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Are you sure you want to delete this request?',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel Button
                    GestureDetector(
                      child: Container(
                        width: 30.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor('003399')),
                          borderRadius: BorderRadius.circular(3.h),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: HexColor('003399'),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        width: 30.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor('003399')),
                          borderRadius: BorderRadius.circular(3.h),
                          color: HexColor('003399'),
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToOperationScreen(BuildContext context, DateTime date, String status, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperationScreen(initialDate: date, initialDescription: status, initialLeaveType: type),
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final DateTime date;
  final String status;
  final String type;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  AttendanceCard({
    required this.date,
    required this.status,
    required this.type,
    required this.onDelete,
    required this.onEdit,
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
                        Text(
                          DateFormat('EEEE, MMM dd, yyyy').format(date),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
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
                          type,
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
          },
        );
      case 'Pending':
        return Row(
          children: [
            IconButton(
              icon: Icon(
                IconlyBroken.delete,
                size: 5.w,
              ),
              onPressed: () {
                onDelete();
              },
            ),
            SizedBox(width: 1.w),
            IconButton(
              icon: Icon(
                IconlyBroken.edit,
                size: 5.w,
              ),
              onPressed: onEdit,
            ),
          ],
        );
      case 'Rejected':
        return Row(
          children: [
            IconButton(
              icon: Icon(
                IconlyBroken.addUser,
                size: 5.w,
              ),
              onPressed: () {
                print("Add User icon clicked");
              },
            ),
            SizedBox(width: 1.w),
            IconButton(
              icon: Icon(
                IconlyBroken.document,
                size: 5.w,
              ),
              onPressed: () {
                print("Document icon clicked");
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
