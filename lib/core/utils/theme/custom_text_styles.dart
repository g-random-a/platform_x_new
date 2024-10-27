
import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/app_colors.dart';

extension on TextStyle {

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
  
  TextStyle get epilogue {
    return copyWith(
      fontFamily: 'Epilogue',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get plusJakartaSans {
    return copyWith(
      fontFamily: 'Plus Jakarta Sans',
    );
  }

  TextStyle get redHatDisplay {
    return copyWith(
      fontFamily: 'Red Hat Display',
    );
  }
  

}

class CustomTextStyles {

  // Body text style
  static TextStyle bodySmallEpilogueBlack90001 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.bodySmall!.epilogue.copyWith(
        color: appColorTheme.black90001,
      );

  static TextStyle bodySmallEpilogueBluegray700 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.bodySmall!.epilogue.copyWith(
        color: appColorTheme.blueGray700,
        fontSize: 10.fSize,
      );

  static TextStyle bodySmallOnErrorContainer (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.bodySmall!.copyWith(
        color: appColorTheme.black90001,
        fontSize: 12.fSize,
      );

  static TextStyle bodySmallPlusJakartaSansBlack90001 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.bodySmall!.plusJakartaSans.copyWith(
        color: appColorTheme.black90001,
        fontSize: 10.fSize,
      );

  static TextStyle bodySmallPlusJakartaSansOnErrorContainer (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.bodySmall!.plusJakartaSans.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 12.fSize,
      );

  static TextStyle labelLargePlusJakartaSans (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelLarge!.plusJakartaSans.copyWith(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelLargePlusJakartaSans13 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelLarge!.plusJakartaSans.copyWith(
        fontSize: 13.fSize,
      );

  static TextStyle labelLargeSecondaryContainer (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelLarge!.copyWith(
        color: themeData.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w600,
      );

  static TextStyle labelMediumBlack90001 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: appColorTheme.black90001,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelMediumBlack90001_1 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: appColorTheme.black90001,
      );

  static TextStyle labelMediumInterGreen700 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.inter.copyWith(
        color: appColorTheme.green700,
        fontWeight: FontWeight.w600,
      );

  static TextStyle bodyMediumInterBlack500 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.bodyMedium!.inter.copyWith(
        color: appColorTheme.black900,
        fontWeight: FontWeight.w500,
        fontSize: 13.fSize
      );

  static TextStyle labelMediumInterPrimary(ThemeData themeData, AppColorTheme appColorTheme) => 
      themeData.textTheme.labelMedium!.inter.copyWith(
        color: themeData.colorScheme.primary,
        fontWeight: FontWeight.w600,
        fontSize: 12.35.fSize
      );
  
  static TextStyle labelMediumInterBlack(ThemeData themeData, AppColorTheme appColorTheme) => 
      themeData.textTheme.labelMedium!.inter.copyWith(
        color: appColorTheme.black900,
        fontWeight: FontWeight.w600,
        fontSize: 12.35.fSize
      );

  static TextStyle labelMediumOnErrorContainer (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 11.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelMediumOnErrorContainer11 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 11.fSize,
      );

  static TextStyle labelMediumOnErrorContainerBold (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 11.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelMediumOnErrorContainerSemiBold (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );

  static TextStyle labelMediumOrange600 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: appColorTheme.orange600,
        fontSize: 11.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelMediumPoppinsOnErrorContainer (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.poppins.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
      );

  static TextStyle labelMediumWhiteA70001 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelMedium!.copyWith(
        color: appColorTheme.whiteA70001,
        fontSize: 11.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle labelSmallEpilogueIndigoA700 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelSmall!.epilogue.copyWith(
        color: appColorTheme.indigoA700,
      );

  static TextStyle labelSmallEpilogueYellow700 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.labelSmall!.epilogue.copyWith(
        color: appColorTheme.yellow700,
      );

// Title text style

  static TextStyle titleLargePlusJakartaSansBlack900 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleLarge!.plusJakartaSans.copyWith(
        color: appColorTheme.black90002,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle titleMediumPlusJakartaSansBlack900 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleMedium!.plusJakartaSans.copyWith(
        color: appColorTheme.black900,
        fontSize: 17.fSize,
        fontWeight: FontWeight.w800,
      );

  static TextStyle titleMediumPlusJakartaSansBlack900ExtraBold (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleMedium!.plusJakartaSans.copyWith(
        color: appColorTheme.black900,
        fontSize: 19.fSize,
        fontWeight: FontWeight.w800,
      );

  static TextStyle titleMediumPlusJakartaSansOnErrorContainer (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleMedium!.plusJakartaSans.copyWith(
        color: themeData.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 18.fSize,
      );

  static TextStyle titleMediumPlusJakartaSansOnPrimary (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleMedium!.plusJakartaSans.copyWith(
        color: themeData.colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      );

  static TextStyle titleSmallPlusJakartaSansOnPrimary (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleSmall!.plusJakartaSans.copyWith(
        color: themeData.colorScheme.onPrimary,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle titleSmallPlusJakartaSansOnPrimaryMedium (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleSmall!.plusJakartaSans.copyWith(
        color: themeData.colorScheme.onPrimary,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle titleSmallPlusJakartaSansOnPrimaryMedium_1 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleSmall!.plusJakartaSans.copyWith(
        color: themeData.colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      );

  // red hat display
  static TextStyle titleRedHatDisplayOnGray90001 (ThemeData themeData, AppColorTheme appColorTheme) =>
      themeData.textTheme.titleLarge!.redHatDisplay.copyWith(
        color: appColorTheme.gray90001,
        fontSize: 14.37.fSize,
        fontWeight: FontWeight.w500,
      );
      
}
