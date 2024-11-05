import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isObscureOldPassword = true;
  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  bool _validateInputs() {
    if (_oldPasswordController.text.isEmpty) {
      _showSnackBar('Please enter your old password.');
      return false;
    }
    if (_newPasswordController.text.isEmpty) {
      _showSnackBar('Please enter your new password.');
      return false;
    }
    if (_confirmPasswordController.text.isEmpty) {
      _showSnackBar('Please confirm your new password.');
      return false;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showSnackBar('New password and confirm password do not match.');
      return false;
    }
    return true;
  }

  Widget _buildPasswordField({
    required String labelText,
    required bool isObscure,
    required Function() toggleVisibility,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              _buildPasswordField(
                labelText: 'Old Password',
                isObscure: _isObscureOldPassword,
                toggleVisibility: () => _togglePasswordVisibility(true, false),
                controller: _oldPasswordController,
              ),
              SizedBox(height: 2.h),
              _buildPasswordField(
                labelText: 'New Password',
                isObscure: _isObscureNewPassword,
                toggleVisibility: () => _togglePasswordVisibility(false, true),
                controller: _newPasswordController,
              ),
              SizedBox(height: 2.h),
              _buildPasswordField(
                labelText: 'Confirm Password',
                isObscure: _isObscureConfirmPassword,
                toggleVisibility: () => _togglePasswordVisibility(false, false),
                controller: _confirmPasswordController,
              ),
              SizedBox(height: 4.h),
              ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    _showSnackBar('Password changed successfully');
                  }
                },
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
      ),
    );
  }
}
