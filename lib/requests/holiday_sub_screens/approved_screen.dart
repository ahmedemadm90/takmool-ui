import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ApprovedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('data'),
            )
          ],
        ),
      ),
    );
  }
}