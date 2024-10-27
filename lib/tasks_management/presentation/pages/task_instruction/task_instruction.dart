import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';

import '../../../../core/application/theme/bloc/theme_bloc.dart';

class TaskInstructionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: 'https://s3-alpha-sig.figma.com/img/9548/c73f/6e6685c25540446a516920842e05f72f?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=AZdeYmuEmYVXC152R-lejy~QKzfGNiM7dzHMNq~zvPzC6X0dZ1klRjjgBmzTV6mGD-JBtuhLYc8NGRVom5q6R-D8OjZooqXYscRWeSUmOGqi0J8zMHtRNZ~DOdKC9hbxt8gYZuuwbZHB3YQuN9Ikr4ZzxE2P8w5oR9Rv-TubLXRGIV-hLwEbKuLqmwIpH9auuTLxRKAEjc7XPEDMfBecjOfuBThTqAuYVOPxJ6cWrGqRd1I4nEcuzM27chvnrxPm5JNRSIonH6I~0VkxMPbQm3O0hRcIvTqwidDOja3e89jQwCCUsAHK1Ow91R~FDSXG9El80MkAvUHbmaeve7st9Q__',
                  border: Border.all(
                    color: context.watch<ThemeBloc>().state.appColorTheme.gray300
                    ),
                  radius: BorderRadius.only(
                    topLeft: Radius.circular(50.h),
                    topRight: Radius.circular(50.h),
                    bottomRight: Radius.circular(50.h)
                  ),
                  height: 294.vh,
                  // width: 314.h,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 16),
                // Title section
                Text(
                  "Financial Access Survey",
                  style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                  
                ),
                const SizedBox(height: 8),
                Text(
                  "As part of the survey, we are collecting inputs from various stakeholders, and we are seeking your",
                  style: CustomTextStyles.bodySmallOnErrorContainer(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
                const SizedBox(height: 16),
                // Due date section 
                Row(
                  children: [
                    Icon(Iconsax.calendar_1, size: 14.fSize, color: context.watch<ThemeBloc>().state.appColorTheme.black90001,),
                    const SizedBox(width: 8),
                    Text(
                      "Due: Oct 29, 2023",
                      style: CustomTextStyles.bodyMediumInterBlack500(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                        fontSize: 12.25.fSize,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Earnings and Tasks section
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.h),
                    border: Border.all(color: context.watch<ThemeBloc>().state.appColorTheme.gray300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total Earning
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                        decoration: BoxDecoration(
                              color: context.watch<ThemeBloc>().state.appColorTheme.blue50,
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Earning",
                              style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                fontSize: 14.fSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "10000Br.",
                              style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                fontSize: 18.fSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Task List
                      Container(
                        padding: EdgeInsets.fromLTRB(16.h, 8.h, 16.h, 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Tasks", 
                              style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                fontSize: 14.fSize,
                                fontWeight: FontWeight.w500,
                              ),),
                            Text(
                              "10", 
                              style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                fontSize: 17.fSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildTaskRow(context, Iconsax.microphone, "Speech generation", 2),
                      const CustomDivider(),
                      _buildTaskRow(context, Iconsax.image, "Document digitization", 2),
                      const CustomDivider(),
                      _buildTaskRow(context, Iconsax.message, "Annotation and labeling", 2),
                      SizedBox(height: 4.h,)
                    ],
                  ),
                ),
                // const Spacer(),
                SizedBox(height: 20.h),
                // Start Task Button
                CustomElevatedButton(
                  backgroundColor: Colors.black,
                  onclick: () {
                    // go route to /task_instruction - use go routing
                    context.go('/Survey');
                  },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskRow(BuildContext context, IconData icon, String taskName, int count) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 8.h), 
          Text(
            taskName, 
            style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                          fontSize: 11.78.fSize,
                          fontWeight: FontWeight.w500,
                          color: context.watch<ThemeBloc>().state.appColorTheme.gray900,
                        ),),
            ],
          ),
          Text(count.toString(),
              style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                              fontSize: 11.78.fSize,
                              fontWeight: FontWeight.w500,
                              color: context.watch<ThemeBloc>().state.appColorTheme.gray900,
                            ),),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double? padding;

  const CustomDivider({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 8.0.h),
      child: Divider(
        color: context.watch<ThemeBloc>().state.appColorTheme.gray300,
        thickness: 1,
      ),
    );
  }
}