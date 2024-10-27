import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';

class CustomRatingBar extends StatelessWidget {

  const CustomRatingBar(
    { super.key,
      this.alignment,
      this.ignoreGestures,
      this.initialRating,
      this.itemSize,
      this.itemCount,
      this.color,
      this.unselectedColor,
      this.onRatingUpdate,
      this.minRating,
      this.icon = true
      });

  final Alignment? alignment;
  final bool? ignoreGestures;
  final double? initialRating;
  final double? itemSize;
  final int? itemCount;
  final Color? color;
  final Color? unselectedColor;
  final bool icon;
  final double? minRating;

  final Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: ignoreGestures ?? false,
      initialRating: initialRating ?? 0,
      minRating: minRating ?? 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemSize: itemSize ?? 18.h,
      unratedColor: unselectedColor,
      itemCount: itemCount ?? 5,
      updateOnDrag: true,
      // itemBuilder: (context, ind) => icon ?
      // Icon(
      //   Icons.star,
      //   color: color ?? context.watch<ThemeBloc>().state.appColorTheme.gray900,
      // ) : Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20.h),
      //   ),
      //   child: Text(ind.toString()),
      // ),

      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: color ?? context.watch<ThemeBloc>().state.appColorTheme.gray900,
        size: itemSize,
      ),
      onRatingUpdate: (rating) {
        onRatingUpdate!.call(rating);
      },
    );
  }
}
