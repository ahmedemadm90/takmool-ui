import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:takamool/auth/reset_passwors_screen.dart';
import 'dart:ui'; // For BackdropFilter

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isDialogOpen = false;

  // Show logout dialog with blur effect
  void _showLogoutDialog() {
    setState(() {
      _isDialogOpen = true;
    });
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          height: 100.h,
          width: 100.w,
          color: Colors.black.withOpacity(.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: 25.h,
                width: 95.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.7),
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    Text('Log out',style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'cairo',
                      color: Colors.white
                    ),),
                    SizedBox(height: 20.sp,),
                    Text('Are you sure to sign out of your account ?',style: TextStyle(
                      fontFamily: 'cairo',
                      color: Colors.white,
                      fontSize: 15.sp
                    ),),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 30.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: HexColor('#003087'),
                                borderRadius: BorderRadius.circular(5.h)
                              ),
                              child: Center(
                                child: Text('Cancel',style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'cairo',

                                ),),
                              ),
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            width: 30.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5.h)
                            ),
                            child: Center(
                              child: Text('Logout',style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'cairo',

                              ),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    ).then((_) {
      setState(() {
        _isDialogOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('E5E7EB'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
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
            Container(
              width: 95.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/img.jpg'),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Karim Mohammed',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'UiUX Designer',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    ProfileOption(
                      leadingWidget: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image(image: AssetImage('assets/images/bg.png')),
                          Icon(IconlyBroken.lock),
                        ],
                      ),
                      title: 'Change Password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ProfileOption(
                      leadingWidget: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image(image: AssetImage('assets/images/bg.png')),
                          Image(
                            image: AssetImage('assets/images/translate.png'),
                          ),
                        ],
                      ),
                      title: 'Language',
                      onTap: () {
                        // Language change functionality
                      },
                    ),
                    Divider(),
                    ProfileOption(
                      leadingWidget: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image(image: AssetImage('assets/images/bg.png')),
                          Icon(IconlyBroken.logout, color: Colors.red),
                        ],
                      ),
                      title: 'Log out',
                      titleColor: Colors.red,
                      onTap: _showLogoutDialog, // Show the logout confirmation
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final Widget leadingWidget;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const ProfileOption({
    Key? key,
    required this.leadingWidget,
    required this.title,
    this.titleColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leadingWidget,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey[600],
        size: 16,
      ),
    );
  }
}
