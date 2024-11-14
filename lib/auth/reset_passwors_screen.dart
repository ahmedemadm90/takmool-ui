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

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

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

  bool _validateInputs() {
    bool isValid = true;
    setState(() {
      // Reset all errors first
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;

      if (_oldPasswordController.text.isEmpty) {
        _oldPasswordError = 'Please enter your old password';
        isValid = false;
      }

      if (_newPasswordController.text.isEmpty) {
        _newPasswordError = 'Please enter your new password';
        isValid = false;
      }

      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Please confirm your new password';
        isValid = false;
      } else if (_newPasswordController.text != _confirmPasswordController.text) {
        _confirmPasswordError = 'Passwords do not match';
        isValid = false;
      }
    });
    return isValid;
  }

  Widget _buildPasswordField({
    required String labelText,
    required bool isObscure,
    required Function() toggleVisibility,
    required TextEditingController controller,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: errorText != null ? Colors.red : HexColor('#6B7280'),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(color: HexColor('#D1D5DB')),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(
            color: errorText != null ? Colors.red : HexColor('#D1D5DB'),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: BorderSide(
            color: errorText != null ? Colors.red : HexColor('#003087'),
          ),
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12.sp,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? IconlyBroken.show : IconlyBroken.hide,
            color: errorText != null ? Colors.red : HexColor('#6B7280'),
          ),
          onPressed: toggleVisibility,
        ),
      ),
      obscureText: isObscure,
      onChanged: (value) {
        // Clear error when user starts typing
        if (errorText != null) {
          setState(() {
            if (controller == _oldPasswordController) _oldPasswordError = null;
            if (controller == _newPasswordController) _newPasswordError = null;
            if (controller == _confirmPasswordController) _confirmPasswordError = null;
          });
        }
      },
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
                errorText: _oldPasswordError,
              ),
              SizedBox(height: 2.h),
              _buildPasswordField(
                labelText: 'New Password',
                isObscure: _isObscureNewPassword,
                toggleVisibility: () => _togglePasswordVisibility(false, true),
                controller: _newPasswordController,
                errorText: _newPasswordError,
              ),
              SizedBox(height: 2.h),
              _buildPasswordField(
                labelText: 'Confirm Password',
                isObscure: _isObscureConfirmPassword,
                toggleVisibility: () => _togglePasswordVisibility(false, false),
                controller: _confirmPasswordController,
                errorText: _confirmPasswordError,
              ),
              SizedBox(height: 4.h),
              ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Password changed successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
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