import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<String> languages = ['العربية', 'English'];
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FBFBFB'),
      appBar: AppBar(
        backgroundColor: HexColor('#FFFFFF'),
        elevation: 0,
        title: Text(
          'Language',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguage = languages[index];
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: HexColor('#D1D5DB'), // Border color for the container
                ),
                borderRadius: BorderRadius.all(Radius.circular(2.w)), // Square corners
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          // Base image
                          Image.asset(
                            'assets/images/bluebg.png',
                            width: 7.w, // Adjust width as needed
                          ),
                          // Overlay image based on selected language
                          Positioned.fill(
                            child: Container(
                              width: 2.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50), // Optional: add some border radius
                              ),
                              child: Center(
                                child: Text(
                                  languages[index] == 'العربية' ? 'Ar' : 'En',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp, // Optional: adjust font size as needed
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(width: 8), // Space between image and text
                      Text(
                        languages[index],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // Check mark with square border
                  Container(
                    height: 2.h,
                    width: 2.h, // Square shape
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Keep it transparent
                      border: Border.all(
                        color: Colors.black, // Black border for the check mark
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(1.w)), // Square corners
                    ),
                    child: Icon(
                      Icons.check,
                      color: selectedLanguage == languages[index]
                          ? Colors.black // Black icon if selected
                          : Colors.white, // White icon if not selected
                      size: 16.sp, // Adjust size as needed
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
