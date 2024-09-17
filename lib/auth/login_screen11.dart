import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController companyCodeController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool _rememberMe = false; // Variable to track checkbox state

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void initState() {
    super.initState();
    companyCodeController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    companyCodeController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: 100.w,
            height: 100.h,
            color: HexColor('003399'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Container(
                    width: 80.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Hello There',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              color: Colors.white.withOpacity(.5),
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Image(image: AssetImage('assets/images/vector.png')),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  width: 100.w,
                  height: 112.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                  ),
                  child: Form(
                    key: _formKey, // Assign the form key
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login to Your Account',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Make sure that you already have an account.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        TextFormField(
                          controller: companyCodeController,
                          decoration: InputDecoration(
                            labelText: 'Company Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your company code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: 'Email or Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email or phone number';
                            }
                            // Check if it's a valid email format
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value) &&
                                !RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
                              return 'Please enter a valid email or phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Handle login if validation is successful
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing...')),
                                );
                              }
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('#003399'), // Set button color to blue
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Make it round
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
