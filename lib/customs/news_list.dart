import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async {
  if (url.isEmpty) {
    // Handle case where URL is empty
    print('URL is empty');
    return;
  }

  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print('Could not launch $url');
  }
}

Widget newsList({
  required String imageUrl,
  required String source,
  required String date,
  required String headline,


}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent
    ),
    height: 132,
    width: 414,
    child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 22),
      child: Row(
        children: [
          SizedBox(
            height: 100, width: 100,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        source,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 65.w),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Flexible(
                  child: Text(
                    headline,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Rubik',
                    ),
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
