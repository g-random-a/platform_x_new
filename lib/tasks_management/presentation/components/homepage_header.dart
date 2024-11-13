import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/profile/user_profile.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';
import '../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../core/utils/theme/custom_text_styles.dart';
import 'app_bar.dart';

class ContentSection extends StatefulWidget {
  final PageController controller;

  const ContentSection({super.key, required this.controller});

  @override
  _ContentSectionState createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  int page = 0;

  bool showIncentive = false;
  double? incentive;

  // listner function for pageview
  void _listener() {
    setState(() {
      page = widget.controller.page!.round();
    });
  }



  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: context.watch<ThemeBloc>().state.appColorTheme.blue50,
        ),
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: context.read<UserProfileRepository>().loadUserProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  print(snapshot.data);
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0.h),
                    child: CustomAppBar(
                      leading: CircleAvatar(
                            radius: 21.h,
                            backgroundImage: NetworkImage(snapshot.data!['profileImage']),
                          ),
                      leadingWidth: 42.h,
                      title: Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: Text(
                            // "Yonas Y.", 
                            "${snapshot.data!['firstName']} ${snapshot.data!['lastName'][0]}.",
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                          ),
                      ),
                      actions:  [
                        const Icon(Iconsax.notification),
                        SizedBox(width: 5.h,),
                        const Icon(Iconsax.setting_2),
                      ],
                      height: 48.h,
                    ),
                  );
                  
                }

                return CustomAppBar(
                  actions:  [
                        const Icon(Iconsax.notification),
                        SizedBox(width: 5.h,),
                        const Icon(Iconsax.setting_2),
                      ],
                );
              }
            ),
            SizedBox(
              width: double.maxFinite,
              child: buildSeparatorLine(context),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(
                left: 20.h,
                right: 16.h,
                top: 5.h,
                bottom: 5.h
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.wallet_2
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Text(
                          S.of(context).t_total_earning,
                          style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimaryMedium(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        showIncentive ?  "Br. 1,00.05" : "***********",
                        style:
                            CustomTextStyles.titleMediumPlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                      ),
                      SizedBox(width: 5.h,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            showIncentive = !showIncentive;
                          });
                        },
                        child: Icon(
                          showIncentive ? Iconsax.eye_slash : Iconsax.eye
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: buildSeparatorLine(context),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        context.read<TaskManagerService>().getOnProgressTasks().isNotEmpty ? InkWell(
                          onTap: () {
                            widget.controller.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                          },
                          child: Text(
                            S.of(context).t_ongoing,
                            style: page == 0
                                ? CustomTextStyles.labelMediumInterPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme)
                                : CustomTextStyles.labelMediumInterBlack(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                          ),
                        ) : Container(),
                        
                        InkWell(
                          onTap: () {
                            widget.controller.animateTo(MediaQuery.of(context).size.width, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text(
                              S.of(context).t_most_recent,
                              style: page == 1
                                  ? CustomTextStyles.labelMediumInterPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme)
                                  : CustomTextStyles.labelMediumInterBlack(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            widget.controller.animateTo(MediaQuery.of(context).size.width*2, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text(
                              // "Saved",
                              S.of(context).t_saved,
                              style:
                                  page == 2
                                      ? CustomTextStyles.labelMediumInterPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme)
                                      : CustomTextStyles.labelMediumInterBlack(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

/// Section Widget  
Widget buildSeparatorLine(BuildContext context) {  
  return Divider(  
    color: context.watch<ThemeBloc>().state.appColorTheme.blueA100,  
  );  
}  
  
/// Section Widget  
// Widget buildDocumentList(BuildContext context, ScrollController controller) {  
//   return PageView.builder(
//   itemBuilder: (context, index) {
//     return ListView.builder(
//         itemCount: 52,
//         controller: controller,
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
          // return DocumentlistItemWidget(
//             task: Task(
//               id: "1",
//               title: "Task $index",
//               // description: "This is a description of task $index", long description
//               // longest desc
//               description:  "This is very long description for the task at $index location. For document digitization: Capture images of documents and upload. For document digitization: Capture images of documents and upload.",
//               budget: 250,
//               location: "Addis Ababa",
//               rating: 5,
//               tags: [
//                 "18-34+",
//                 "Marketing",
//                 "Sales",
//                 "Business",
//                 "Finance",
//                 "Accounting",
//                 "Management",
//                 "Human Resource",
//                 "Customer Service",
//                 "Information Technology",
//                 "Engineering",
//                 "Healthcare",
//                 "Education",
//               ],
//               totalQuestions: 25,
//               completedQuestions: 5,

//             ),
//           );
//         },
//     );
//   }
//             );
// }