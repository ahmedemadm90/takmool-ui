import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LossAttendanceScreen extends StatefulWidget {
  @override
  _LossAttendanceScreenState createState() => _LossAttendanceScreenState();
}

class _LossAttendanceScreenState extends State<LossAttendanceScreen> {
  String? _selectedLeaveType;
  DateTime? _selectedDate;
  bool _isDialogOpen = false;
  final TextEditingController _descriptionController = TextEditingController();

  // Function to select a date using a date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: HexColor('#003399'),
              onPrimary: Colors.white,
              surface: HexColor('#E5EEFF'),
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: HexColor('#E5EEFF'),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Update the selected date
      });
    }
  }
  void _showRequestDoneDialog() {
    setState(() {
      _isDialogOpen = true;
    });

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
                Image(image: AssetImage('assets/images/done.png')),
                SizedBox(height: 2.h),
                Text(
                  'Request Sent',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _isDialogOpen = false;
      });
    });

    // Automatically close the dialog after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (_isDialogOpen) {
        Navigator.pop(context); // Close the dialog
      }
    });
  }


  // Validate input fields and submit
  void _validateAndSubmit() {
    if (_selectedLeaveType == null) {
      _showError("Please select a leave type.");
      return;
    }
    if (_selectedDate == null) {
      _showError("Please choose a date.");
      return;
    }
    if (_descriptionController.text.isEmpty) {
      _showError("Please enter a description.");
      return;
    }
    _showRequestDoneDialog();
  }
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsetsDirectional.only(
          bottom: 85.h,
          start: 2.w,
          end: 2.w,
        ),
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('F3F4F6'),
      appBar: AppBar(
        backgroundColor: HexColor('FBFBFB'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconlyBroken.arrowLeft2),
        ),
        title: Text(
          'Loss Attendance',
          style: TextStyle(fontFamily: 'cairo'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting leave type
            Container(
              child: DropdownMenu(
                label: const Text('Leave Type'),
                width: 100.w,
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(HexColor('CCDDFF')),
                ),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'value1', label: 'Leave In'),
                  DropdownMenuEntry(value: 'value2', label: 'Leave Out'),
                ],
                onSelected: (value) {
                  setState(() {
                    _selectedLeaveType = value; // Update selected leave type
                  });
                },
              ),
            ),
            SizedBox(height: 1.5.h),
            // Date selection
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Choose Date'
                          : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(IconlyBroken.calendar, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.5.h),
            // Text area for description
            _buildTextAreaField(
              label: 'Description',
              controller: _descriptionController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 2.h),
            // Submit button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('003399'),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.5.h),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Text area field builder
  Widget _buildTextAreaField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: 6,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator, // Validation can be added later if needed
    );
  }

  // Format the time for display
  String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    String formattedMinute = minute.toString().padLeft(2, '0');
    return "$hour:$formattedMinute $period";
  }
}
