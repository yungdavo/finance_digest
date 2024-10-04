import 'package:finance_digest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../customs/custom_widgets.dart';
import '../helper/databasehelper.dart';
import 'notifications.dart';

class LegalName extends StatefulWidget {
  final String firstName;
   const LegalName({super.key, required this.firstName});

  @override
  State<LegalName> createState() => _LegalNameState();
}

class _LegalNameState extends State<LegalName> {

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();

  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();


    firstname.addListener(_validateForm);
    lastname.addListener(_validateForm);
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {

      isButtonActive = firstname.text.isNotEmpty && lastname.text.isNotEmpty;
    });
  }

  void saveName() async {
    String firstNameText = firstname.text;
    String lastNameText = lastname.text;

    if (firstNameText.isNotEmpty && lastNameText.isNotEmpty) {
      await dbHelper.insertUser(firstNameText, lastNameText);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Notifications(firstName: firstNameText),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both first name and last name')
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
            "Your legal name",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 30.sp, fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              child: Text(
                "We need to know a bit about you so "
                    "that we can create your account.",
                style: TextStyle(
                  color: Color(0xFF737373),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  height: 1.5
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          customTextField("First name", firstname),
          customTextField("Last name", lastname),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed:  saveName,
        backgroundColor: isButtonActive ? AppColors.mainColor : Color(0XFFb6adf2),
        child: Icon(
             Icons.navigate_next,
        ),
      ),
    );
  }
}
