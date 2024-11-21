import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/tasks_management/application/task/bloc/task_bloc.dart';
import 'package:platform_x/tasks_management/application/task/event/task_event.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';
import 'package:platform_x/tasks_management/utils/constants/assets/asset_icons.dart';

class CompletionApprovalScreen extends StatelessWidget {
  
  // void showCustomDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Color(0xAAECEEF0),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15.0),
  //         ),
  //         child: 
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEEF0),
      body: SafeArea(
        child: Center(
          child: Container(
              width: 320.h,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: AssetIcon.circleTick,
                      height: 48.5.vh,
                      width: 47.6.h,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      S.of(context).t_task_compleleted_successfully,
                      style:  CustomTextStyles.titleLargePlusJakartaSansBlack900(
                        context.watch<ThemeBloc>().state.themeData, 
                        context.watch<ThemeBloc>().state.appColorTheme, 
                        ).copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 26.34.fSize
                        ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    // Add any content you want here
                    Text(
                      S.of(context).t_task_compleleted_successfully_desc,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodySmallPlusJakartaSansOnErrorContainer(
                        context.watch<ThemeBloc>().state.themeData, 
                        context.watch<ThemeBloc>().state.appColorTheme, 
                        ),
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                      onclick: (){
                        BlocProvider.of<TasksBloc>(context).add(LoadTasksEvent());
                        context.pushReplacement("/tasks");
                      },
                      text: S.of(context).t_back_to_main_screen,
                      backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.black90001,
                      )
                  ],
                ),
              ),
            ),
          
        ),
      ),
    );
  }
}
