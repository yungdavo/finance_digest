import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard.dart';

class Notifications extends StatefulWidget {
  final String firstName;
  const Notifications({super.key, required this.firstName});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  Future<void> _requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {

      if (await Permission.notification.request().isGranted) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notifications enabled successfully!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashBoard(firstName: widget.firstName)),
        );
      } else {
        // Permission denied
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Notification permission denied')
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notifications were already enabled')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoard(firstName: widget.firstName)), // Replace NextPage with your actual next page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
         children: [
           Positioned(
             top: 234, left: 138.5, right: 138.5,
             child: SizedBox(
                 height: 98.h, width: 98.h,
                 child: Image.asset(
                     "assets/imageicons/notification.png"
                 ),
             ),
           ),
           Positioned(
             top: 356, left: 24, right: 24,
             child: SizedBox(
               height: 30.h, width: 327.w,
               child: Text(
                   "Get the most out of Blott ✅",
                    style: TextStyle(
                      color: Color(0xFF1E1F20),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                  ),
                 textAlign: TextAlign.center,
                ),
             ),
           ),
           Positioned(
              top: 402, left: 24, right: 24,
             child: SizedBox(
               height: 48.h, width: 327.w,
               child: Text(
                 "Allow notifications to stay"
                   " in the loop with your payments, "
                   "requests and groups.",
                 style: TextStyle(
                   color: Color(0xFF737373),
                   fontSize: 16.sp,
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Roboto',
                   height: 1.5,
                 ),
                 textAlign: TextAlign.center,
               ),
             ),
           ),
          ]
       ),
      bottomNavigationBar: GestureDetector(
        onTap: ()async{
          await _requestNotificationPermission();
          },
        child: Padding(
          padding:  EdgeInsets.only(left: 24, right: 24, bottom: 34),
          child: Container(
            alignment: Alignment.center,
            height: 48.h,width: 375.w,
            decoration: BoxDecoration(
              color: Color(0XFF523AE4),
              borderRadius: BorderRadius.all(Radius.circular(30)
              ),
            ),
            child: Text(
              "Continue",
              style: TextStyle(
                color: Color(0XFFFAFAFA),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
