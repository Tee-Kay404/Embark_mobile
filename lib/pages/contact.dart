import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.surface,
        title: Text(
          'Contact Us',
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.surface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Text(
                "We'd love to hear from you!",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reach Out',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 14.h),
                  contactRow(context, Icons.phone, '(123) 456-7890'),
                  contactRow(context, Icons.email, 'support@shopapp.com'),
                  contactRow(context, Icons.location_on,
                      '123 Commerce St, TEE_KAY City'),
                  Divider(height: 28.h),
                  Text('Follow us on social media',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      socialIcon(FontAwesomeIcons.globe),
                      socialIcon(FontAwesomeIcons.instagram),
                      socialIcon(FontAwesomeIcons.facebook),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Send a Message',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 18.sp, // Increased from 16.sp
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 14.h),
                  inputField(context, 'Your Name'),
                  inputField(context, 'Email Address'),
                  inputField(context, 'Message', maxLines: 4),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.send, size: 18.sp),
                      label: Text(
                        'Send Message',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 16.sp, // Increased from 14.sp
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contactRow(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialIcon(IconData icon) => Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: CircleAvatar(
          radius: 18.r,
          backgroundColor: Colors.blue.shade100,
          child: FaIcon(icon, size: 18.sp, color: Colors.blue.shade800),
        ),
      );

  Widget inputField(BuildContext context, String hint, {int maxLines = 1}) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextField(
        maxLines: maxLines,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: theme.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 14.w,
          ),
        ),
      ),
    );
  }
}
