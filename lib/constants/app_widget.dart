import 'dart:math';
import 'package:flutter/material.dart';
import 'app_assets.dart';
import 'app_colors.dart';

class AppWidgets{

  Widget dummyCarWidget(){
    return LayoutBuilder(
      builder: (c1, c2) {
        final shortestSide = min(c2.maxHeight, c2.maxWidth);
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: shortestSide * 0.25,
            vertical: shortestSide * 0.25,
          ),
          child: Image.asset(
            AppAssets.carSilhouette,
            color: AppColors.bgHardGrey,
            // height: min(c2.maxHeight*0.5, c2.maxWidth*0.5),
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }


}