import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isObscureOldPassword = true; // Toggle for old password visibility
  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;
  bool _isDialogOpen = false;

  // Method to toggle password visibility
  void _togglePasswordVisibility(bool isOldPassword, bool isNewPassword) {
    setState(() {
      if (isOldPassword) {
        _isObscureOldPassword = !_isObscureOldPassword;
      } else if (isNewPassword) {
        _isObscureNewPassword = !_isObscureNewPassword;
      } else {
        _isObscureConfirmPassword = !_isObscureConfirmPassword;
      }
    });
  }

  // Method to show password changed dialog
  void _showPasswordChangedDialog() {
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
                  'Password Changed',
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

  // Method to build a password field
  Widget _buildPasswordField({
    required String labelText,
    required bool isObscure,
    required Function() toggleVisibility,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: HexColor('#6B7280')),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(color: HexColor('#D1D5DB')),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(color: HexColor('#D1D5DB')),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(color: HexColor('#003087')),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? IconlyBroken.show : IconlyBroken.hide,
            color: HexColor('#6B7280'),
          ),
          onPressed: toggleVisibility,
        ),
      ),
      obscureText: isObscure,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FBFBFB'),
      appBar: AppBar(
        backgroundColor: HexColor('#FFFFFF'),
        elevation: 0,
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconlyBroken.arrowLeft, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            // Old password field with show/hide functionality
            _buildPasswordField(
              labelText: 'Old Password',
              isObscure: _isObscureOldPassword,
              toggleVisibility: () => _togglePasswordVisibility(true, false),
            ),
            SizedBox(height: 2.h),
            // New password field with show/hide functionality
            _buildPasswordField(
              labelText: 'New Password',
              isObscure: _isObscureNewPassword,
              toggleVisibility: () => _togglePasswordVisibility(false, true),
            ),
            SizedBox(height: 2.h),
            // Confirm password field with show/hide functionality
            _buildPasswordField(
              labelText: 'Confirm Password',
              isObscure: _isObscureConfirmPassword,
              toggleVisibility: () => _togglePasswordVisibility(false, false),
            ),
            SizedBox(height: 4.h),
            // Change password button
            ElevatedButton(
              onPressed: _showPasswordChangedDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor('#003087'),
                minimumSize: Size(double.infinity, 7.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.w),
                ),
              ),
              child: Text(
                'Change Password',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
