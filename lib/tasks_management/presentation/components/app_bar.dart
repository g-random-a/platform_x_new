import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';  

enum Style { bgFill }  
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {  
  const CustomAppBar(  
    {super.key,  
    this.height,  
    this.shape,  
    this.styleType,  
    this.leadingWidth,  
    this.leading,  
    this.title,  
    this.centerTitle,  
    this.actions});  
  final double? height;  
  final ShapeBorder? shape;  
  final Style? styleType;  
  final double? leadingWidth;  
  final Widget? leading;  
  final Widget? title;  
  final bool? centerTitle;  
  final List<Widget>? actions;  
  @override  
  Widget build(BuildContext context) {  
    return AppBar(  
      elevation: 0,  
      shape: shape,  
      toolbarHeight: height ?? 38.h,  
      automaticallyImplyLeading: false,  
      backgroundColor: Colors.transparent,  
      flexibleSpace: _getStyle(context),  
      leadingWidth: leadingWidth ?? 0,  
      leading: leading,  
      title: title,  
      titleSpacing: 0,  
      centerTitle: centerTitle ?? false,  
      actions: actions,  
    );  
  }  

  @override  
  Size get preferredSize => Size(  
    SizeUtils.width,  
    height ?? 38.h,  
  );  
    
  _getStyle(BuildContext context) {  
    switch (styleType) {  
      case Style.bgFill:  
        return Container(  
          height: 1.h,  
          width: double.maxFinite,  
          margin: EdgeInsets.only(top: 38.h),  
          decoration: BoxDecoration(  
            color:  context.watch<ThemeBloc>().state.appColorTheme.blue200,  
          ),  
        );  
      default:  
        return null;  
    }  
  }
}