import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/generated/l10n.dart';
import '../../../core/application/theme/bloc/theme_bloc.dart';
import 'package:iconsax/iconsax.dart';

enum BottomBarEnum { Home, Tasks, Wallet, History, Profile }

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});
  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: Iconsax.home_2,
      activeIcon: Iconsax.home_25,
      title: S.of(context).tab_home,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: Iconsax.document_text,
      activeIcon: Iconsax.document_text5,
      title: S.of(context).tab_tasks,
      type: BottomBarEnum.Tasks,
    ),
    BottomMenuModel(
      icon: Iconsax.wallet_3,
      activeIcon: Iconsax.empty_wallet_time4,
      title: S.of(context).tab_wallet,
      type: BottomBarEnum.Wallet,
    ),
    BottomMenuModel(
      icon: Iconsax.clock,
      activeIcon: Iconsax.clock5,
      title: S.of(context).tab_history,
      type: BottomBarEnum.History,
    ),
    BottomMenuModel(
      icon: Iconsax.user,
      activeIcon: Iconsax.user,
      title: S.of(context).tab_profile,
      type: BottomBarEnum.Profile,
    ),
  ];

    return Container(
      height: 68.h,
      decoration: BoxDecoration(
        color: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.h),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0X05000000),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              -2,
            ),
          )
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: bottomNavIcon(icon: Icon(bottomMenuList[index].icon, size: 21.98.fSize), title: bottomMenuList[index].title, isActive: false,),
            activeIcon: bottomNavIcon(icon: Icon(bottomMenuList[index].activeIcon, color: context.watch<ThemeBloc>().state.appColorTheme.black900, size: 21.98.fSize,), title: bottomMenuList[index].title, isActive: true),
            label: '',
          );
        }),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
            widget.onChanged?.call(bottomMenuList[index].type);
        },
      ),
    );
  }
}

class bottomNavIcon extends StatelessWidget {
  const bottomNavIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
  });

  final Icon icon;
  final String? title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(height: 6.h),
        Text(
          title ?? "",
          style: context
              .watch<ThemeBloc>()
              .state
              .themeData
              .textTheme
              .labelMedium!.copyWith(
                color: isActive ? context.watch<ThemeBloc>().state.appColorTheme.black900 : context.watch<ThemeBloc>().state.appColorTheme.black800,
              ),
        ),
      ],
    );
  }
}


class BottomMenuModel {  
  BottomMenuModel({  
    required this.icon,  
    required this.activeIcon,  
    this.title,  
    required this.type,  
  });  
  
  IconData icon;  
  IconData activeIcon;  
  String? title;  
  BottomBarEnum type;  
}  
