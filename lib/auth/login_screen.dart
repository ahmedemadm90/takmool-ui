import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          color: HexColor('#003399'),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _buildWelcomeBanner(),
              SizedBox(height: 5.h),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: 80.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hello, There',
            style: TextStyle(
              fontFamily: 'cairo',
              color: Colors.white.withOpacity(.3),
              fontSize: 19.sp,
            ),
          ),
          Text(
            'Welcome Back',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 24.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 3.h),
          Image(image: AssetImage('assets/images/vector.png')),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Expanded(
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              _buildLoginTitle(),
              SizedBox(height: 1.h),
              _buildLoginFormFields(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTitle() {
    return Text(
      'Login to Your Account',
      style: TextStyle(
        fontSize: 18.sp,
        fontFamily: 'cairo',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLoginFormFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Make sure that you already have an account.',
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'cairo',
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.5),
            ),
          ),
          SizedBox(height: 3.h),
          _buildTextFormField(
            controller: companyCodeController,
            label: 'Company Code',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Company Code';
              }
              return null;
            },
          ),
          SizedBox(height: 1.h),
          _buildTextFormField(
            controller: emailController,
            label: 'E-Mail',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 1.h),
          _buildTextFormField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
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
          _buildRememberMeAndForgotPassword(),
          SizedBox(height: 2.h),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
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
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  rememberMe = value ?? false;
                });
              },
            ),
            Text('Remember Me!', style: TextStyle(color: Colors.grey)),
          ],
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Password recovery feature coming soon!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text(
            'Forget Password?',
            style: TextStyle(color: HexColor('003399')),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor('#003399'),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: MaterialButton(
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            // Handle login logic
          }
        },
        child: Text(
          'Signin',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
