import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/application/task/bloc/saved_tasks_bloc.dart';
import 'package:platform_x/tasks_management/application/task/bloc/task_bloc.dart';
import 'package:platform_x/tasks_management/application/task/event/saved_tasks_event.dart';
import 'package:platform_x/tasks_management/domain/task/task.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_rating_bar.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';

import '../../../core/utils/theme/app_decoration.dart';
import '../../../core/utils/theme/custom_text_styles.dart';
import 'custom_elevated_button.dart';

class DocumentlistItemWidget extends StatefulWidget {
  final Task task;
  final bool inprogress;

   const DocumentlistItemWidget({super.key, required this.task, required this.inprogress});

  @override
  State<DocumentlistItemWidget> createState() => _DocumentlistItemWidgetState();
}

class _DocumentlistItemWidgetState extends State<DocumentlistItemWidget> {
  bool showAllDesc = false;
  bool isOverflowing = false;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverflow();
    });
  }

  @override
  void didUpdateWidget(covariant DocumentlistItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverflow();
    });
  }

  void _checkOverflow() {
    // Accessing context after the widget is built
    final theme = context.read<ThemeBloc>().state.themeData;
    final appColorTheme = context.read<ThemeBloc>().state.appColorTheme;

    final span = TextSpan(
      text: widget.task.description,
      style: CustomTextStyles.bodySmallOnErrorContainer(theme, appColorTheme),
    );

    final tp = TextPainter(
      maxLines: 2,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: span,
    );

    tp.layout(maxWidth: MediaQuery.of(context).size.width); // Use available width

    if (tp.didExceedMaxLines != isOverflowing) {
      setState(() {
        isOverflowing = tp.didExceedMaxLines;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 7.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
            borderRadius: BorderRadiusStyle.roundedBorder5,
            border: Border.all(
              color: context.watch<ThemeBloc>().state.themeData.colorScheme.primaryContainer,
              width: 0.69.h,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // "For document digitization: Capture images of documents and upload. For document digitization: Capture images of documents and upload.",
                        widget.task.title,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: context.watch<ThemeBloc>().state.themeData.textTheme.titleSmall!.copyWith(
                          height: 1.34,
                        ),
                      ),
                    ),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgPHeartLight,
                    //   height: 16.h,
                    //   width: 20.h,
                    // ),
                    IconButton(
                      onPressed: () async{
                        if (widget.task.isFavorite){
                          widget.task.isFavorite = false;
                          BlocProvider.of<SavedTasksBloc>(context).add(RemoveFromFavoriteEvent(task: widget.task));
                        } else {
                          widget.task.isFavorite = true;
                          BlocProvider.of<SavedTasksBloc>(context).add(SaveToFavoriteEvent(task: widget.task));
                        }
                        setState(() {
                        });
                      },
                      icon: Icon(
                        widget.task.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: widget.task.isFavorite ? context.watch<ThemeBloc>().state.appColorTheme.blue700 : context.watch<ThemeBloc>().state.appColorTheme.black90001,
                        size: 20.h,
                      ),
                    )
                  ],
                ),
              ),
        
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  children: [
                    Text(
                      // "Est. Budget 200Br.",
                      "${S.of(context).t_est_budget} ${widget.task.budget} ${S.of(context).t_points}",
                      style: CustomTextStyles.bodySmallEpilogueBluegray700(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                    ),
                    Container(
                      height: 2.h,
                      width: 2.h,
                      margin: EdgeInsets.only(left: 6.h),
                      decoration: BoxDecoration(
                        color: context.watch<ThemeBloc>().state.appColorTheme.blueGray700,
                        borderRadius: BorderRadius.circular(
                          1.h,
                        ),
                      ),
                    ),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgSettingsBlueGray7001,
                    //   height: 12.h,
                    //   width: 12.h,
                    //   margin: EdgeInsets.only(left: 4.h),
                    // ),
                    SizedBox(width: 4.h),
                    Icon(
                      Iconsax.location,
                      color: context.watch<ThemeBloc>().state.appColorTheme.black90001,
                      size: 13.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        // "Debremarkos",
                        widget.task.location,
                        style: CustomTextStyles.bodySmallEpilogueBluegray700(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                      ),
                    )
                  ],
                ),
              ),
              
              SizedBox(height: 12.h),
              _buildCustomText(context),
              if (isOverflowing)
              TextButton(
                onPressed: () {
                  setState(() {
                      showAllDesc = !showAllDesc;
                    });
                },
                child: Text( showAllDesc ?  S.of(context).t_showless : S.of(context).t_More,
                    style: CustomTextStyles.labelMediumInterGreen700(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                      textBaseline: TextBaseline.ideographic,
                      decoration: TextDecoration.underline,
                    ),
                    
                    ),
              ),
              if (!isOverflowing) SizedBox(height: 12.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.antiAlias,

                child: Row(
                  children: List.generate(
                    widget.task.tags.length, 
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.h),
                      child: _buildTagsComponent(context, index, widget.task.tags[index]),
                    )
                    )
                ),
              ),
              SizedBox(height: 12.h),
              const CustomRatingBar(
                ignoreGestures: true,
                initialRating: 5,
              ),
              SizedBox(height: 12.h),
              if(widget.task.completedQuestions != null)
              if(widget.inprogress)
              Container(
                height: 4.h,
                width: 360.h,
                decoration: BoxDecoration(
                  color: context.watch<ThemeBloc>().state.themeData.colorScheme.primaryContainer,
                ),
                child: ClipRRect(
                  child: LinearProgressIndicator(
                    value: widget.task.completedQuestions! / widget.task.totalQuestions,
                    backgroundColor: context.watch<ThemeBloc>().state.themeData.colorScheme.secondary,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.watch<ThemeBloc>().state.appColorTheme.teal1300,
                    ),
                  ),
                ),
              ),
              if(widget.inprogress)
              SizedBox(height: 8.h),
              if(widget.inprogress)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.task.completedQuestions!.toString(),
                      style: context.watch<ThemeBloc>().state.themeData.textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: " ${S.of(context).t_out}",
                      style: context.watch<ThemeBloc>().state.themeData.textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: " ${S.of(context).t_of} ",
                      style: context.watch<ThemeBloc>().state.themeData.textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: widget.task.totalQuestions.toString(),
                      style: context.watch<ThemeBloc>().state.themeData.textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: " ${S.of(context).t_completed}",
                      style: context.watch<ThemeBloc>().state.themeData.textTheme.bodySmall,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              if(widget.inprogress)
              SizedBox(height: 14.h),
              // CustomElevatedButton(
              //   text: "Start Task",
              // ),
              CustomElevatedButton(
                text: S.of(context).t_start_task,
                onclick: () {
                  context.go('/tasks/task_instruction', extra: {
                    "task": widget.task
                  });
                },
              )

            ],
          ),
        );
  }

  Container _buildTagsComponent(BuildContext context, int index, String tag) {
    return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.h,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                      border: Border.all(
                        color: index%2 == 0 ? context.watch<ThemeBloc>().state.appColorTheme.yellow700 : context.watch<ThemeBloc>().state.appColorTheme.indigoA700,
                        width: 0.69.h,
                      ),
                    ),
                    child: Text(
                      tag,
                      style: index%2 == 0 ? CustomTextStyles.labelSmallEpilogueYellow700(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme) :  CustomTextStyles.labelSmallEpilogueIndigoA700(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),

                    ),
                  );
  }

  // Text _buildCustomText(BuildContext context) {
  //   return Text(
  //             // "As part of the survey, we are collecting inputs from various stakeholders, and we are seeking your ......",
  //             widget.task.description,
  //             maxLines: showAllDesc ? null : 2,
  //             softWrap: showAllDesc ? true : false,
  //             overflow: showAllDesc ? TextOverflow.visible : TextOverflow.ellipsis,
  //             style: CustomTextStyles.bodySmallOnErrorContainer(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
  //           );
  // }

  Widget _buildCustomText(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Text(
          widget.task.description,
          maxLines: showAllDesc ? null : 2,
          softWrap: true,
          overflow: showAllDesc ? TextOverflow.visible : TextOverflow.ellipsis,
          style: CustomTextStyles.bodySmallOnErrorContainer(
              context.watch<ThemeBloc>().state.themeData,
              context.watch<ThemeBloc>().state.appColorTheme),
        );
      },
    );
  }
}

