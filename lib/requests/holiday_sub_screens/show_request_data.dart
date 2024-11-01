import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class OperationScreen extends StatefulWidget {
  final String? initialLeaveType;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final String? initialDescription;
  final String status; // Required status parameter

  OperationScreen({
    this.initialLeaveType,
    this.initialStartDate,
    this.initialEndDate,
    this.initialDescription,
    required this.status,
  });

  @override
  _OperationScreenState createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {

  String? _selectedLeaveType;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isDialogOpen = false;
  bool _showAdditionalFieldHr = false;
  bool _showAdditionalFieldLead = false;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.initialDescription ?? '';
    _selectedLeaveType = widget.initialLeaveType;
    _selectedStartDate = widget.initialStartDate; // Initialize start date
    _selectedEndDate = widget.initialEndDate; // Initialize end date
  }

  // Function to select a date using a date picker
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_selectedStartDate ?? DateTime.now())
          : (_selectedEndDate ?? DateTime.now()),
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
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = picked; // Update selected start date
        } else {
          _selectedEndDate = picked; // Update selected end date
        }
      });
    }
  }

  // Function to determine color based on status
  Widget _getStatusContainer() {
    Color bgColor;
    Color textColor;
    switch (widget.status.toLowerCase()) {
      case 'approved':
        bgColor = Colors.green;
        textColor = Colors.white;
        break;
      case 'pending':
        bgColor = HexColor('FCDAD7').withOpacity(.3);
        textColor = Colors.orange;
        break;
      case 'rejected':
        bgColor = HexColor('FCDAD7');
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey;
        textColor = Colors.black;
        break;
    }
    return Container(
      height: 6.h,
      width: 25.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: bgColor,
      ),
      child: Center(
        child: Text(
          widget.status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
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

    Future.delayed(Duration(seconds: 2), () {
      if (_isDialogOpen) {
        Navigator.pop(context);
      }
    });
  }

  void _validateAndSubmit() {
    if (_selectedLeaveType == null) {
      _showError("Please select a leave type.");
      return;
    }
    if (_selectedStartDate == null) {
      _showError("Please choose a start date.");
      return;
    }
    if (_selectedEndDate == null) {
      _showError("Please choose an end date.");
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

  Widget _getIconContainer() {
    Color bgColor;
    Color textColor;
    Widget? textChild;
    switch (widget.status.toLowerCase()) {
      case 'approved':
        bgColor = Colors.green;
        textColor = Colors.white;
        textChild = Icon(
          Icons.check,
          color: Colors.white,
        );
        break;
      case 'pending':
        bgColor = HexColor('F85640');
        textColor = Colors.orange;
        textChild = Text(
          '!',
          style: TextStyle(color: Colors.white),
        );
        break;
      case 'rejected':
        bgColor = Colors.red;
        textColor = Colors.red;
        textChild = Icon(
          Icons.notifications,
          color: Colors.white,
        );
        break;
      default:
        bgColor = Colors.grey;
        textColor = Colors.black;
        textChild = Icon(Icons.check);
        break;
    }

    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Container(
        height: 4.h,
        width: 9.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: bgColor,
        ),
        child: Center(
          child: textChild,
        ),
      ),
    );
  }

  Widget _getButton() {
    String buttonText;
    Color buttonColor;
    VoidCallback? buttonFunction;

    // Determine button text, color, and function based on status
    switch (widget.status.toLowerCase()) {
      case 'approved':
        buttonText = 'Back';
        buttonColor = HexColor('003399'); // Example color for approved
        buttonFunction = () {
          print('Navigating back...');
          Navigator.pop(context);
        };
        break;
      case 'pending':
        buttonText = 'Edit';
        buttonColor = HexColor('003399'); // Example color for pending
        buttonFunction = () {
          _validateAndSubmit();
          print('Edit');
        };
        break;
      case 'rejected':
        buttonText = 'Re-Apply';
        buttonColor = HexColor('003399'); // Example color for rejected
        buttonFunction = () {
          print('Re-applying...');
          _validateAndSubmit();
        };
        break;
      default:
        buttonText = 'Error';
        buttonColor = HexColor('003399'); // Default color for unknown status
        buttonFunction = null; // No action for error
        break;
    }

    return Padding(
      padding: EdgeInsets.all(2.w),
      child: ElevatedButton(
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
        child: Container(
          height: 4.h,
          width: 50.w,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _hrController =
        TextEditingController(text: 'Ahmed Emad');
    final status = widget.status;

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
          'Operation Screen',
          style: TextStyle(fontFamily: 'cairo'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Container(
                width: 95.w,
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Holiday Detail',
                      style: TextStyle(
                        color: HexColor('003399'),
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    _getStatusContainer(),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () => _selectDate(context, true), // Start date
                      child: Container(
                        height: 6.h,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: HexColor('#003399')),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedStartDate != null
                                  ? "${_selectedStartDate!.toLocal()}"
                                      .split(' ')[0]
                                  : 'Select Start Date',
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(Icons.calendar_today,
                                color: HexColor('#003399')),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () => _selectDate(context, false), // End date
                      child: Container(
                        height: 6.h,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: HexColor('#003399')),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedEndDate != null
                                  ? "${_selectedEndDate!.toLocal()}"
                                      .split(' ')[0]
                                  : 'Select End Date',
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(Icons.calendar_today,
                                color: HexColor('#003399')),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      width: 100.w,
                      child: DropdownMenu(
                        label: const Text('Leave Type'),
                        width: 100.w,
                        menuStyle: MenuStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              HexColor('CCDDFF')),
                        ),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: 'value1', label: 'Leave In'),
                          DropdownMenuEntry(
                              value: 'value2', label: 'Leave Out'),
                        ],
                        onSelected: (value) {
                          setState(() {
                            _selectedLeaveType =
                                value; // Update selected leave type
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TextFormField(
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          // Use OutlineInputBorder
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(
                              4.0), // Optional: add border radius
                        ),
                        hintText: 'Description',
                        contentPadding:
                            EdgeInsets.all(8.0), // Add padding for better UX
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        _buildTextFormField(
                          label: 'HR',
                          controller: _hrController,
                          obscureText: false,
                          validator: (value) {},
                          keyboardType: TextInputType.text,
                        ),
                        _getIconContainer()
                      ],
                    ),
                    ConditionalBuilder(
                      condition: status.toLowerCase() == 'rejected',
                      builder: (context) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAdditionalFieldHr = !_showAdditionalFieldHr; // Toggle visibility
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        _showAdditionalFieldHr ? 'Reason' : 'Reason',
                                        style: TextStyle(color: HexColor('003399')),
                                      ),
                                      SizedBox(width: 2.w,),
                                      Icon(_showAdditionalFieldHr ? Icons.keyboard_arrow_down :Icons.keyboard_arrow_right_rounded),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (_showAdditionalFieldHr)
                              TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8.0),
                                ),
                              ),
                          ],
                        );
                      },
                      fallback: (context) {
                        return SizedBox();
                      },
                    ),
                    SizedBox(height: 2.h),
                    Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        _buildTextFormField(
                          label: 'Tech Lead',
                          controller: _hrController,
                          obscureText: false,
                          validator: (value) {},
                          keyboardType: TextInputType.text,
                        ),
                        _getIconContainer()
                      ],
                    ),
                    ConditionalBuilder(
                      condition: status.toLowerCase() == 'rejected',
                      builder: (context) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showAdditionalFieldLead = !_showAdditionalFieldLead; // Toggle visibility
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        _showAdditionalFieldLead ? 'Reason' : 'Reason',
                                        style: TextStyle(color: HexColor('003399')),
                                      ),
                                      SizedBox(width: 2.w,),
                                      Icon(_showAdditionalFieldLead ? Icons.keyboard_arrow_down :Icons.keyboard_arrow_right_rounded),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (_showAdditionalFieldLead)
                              TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8.0),
                                ),
                              ),
                          ],
                        );
                      },
                      fallback: (context) {
                        return SizedBox();
                      },
                    ),
                    _getButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? iconContainer,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
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
              suffixIcon: iconContainer != null
                  ? Container(
                      width: 2.w, // Set the desired width
                      height: 2.h, // Set the desired height
                      decoration: BoxDecoration(
                        color: Colors.green, // Green background
                        borderRadius:
                            BorderRadius.circular(20), // Rounded container
                      ),
                      child: Center(
                        // Center the icon within the container
                        child: iconContainer,
                      ),
                    )
                  : null,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
