import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selectedLanguage == languages[index]
                    ? HexColor('#003087')
                    : Colors.white,
                border: Border.all(
                  color: HexColor('#D1D5DB'),
                ),
                borderRadius: BorderRadius.zero, // Square corners
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languages[index],
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedLanguage == languages[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  if (selectedLanguage == languages[index])
                    Icon(
                      Icons.check,
                      color: Colors.white,
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
