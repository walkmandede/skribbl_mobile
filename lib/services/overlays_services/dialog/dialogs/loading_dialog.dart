import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/services/others/extensions.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_constants.dart';

class LoadingDialog extends StatelessWidget {
  final String loadingText;
  const LoadingDialog({super.key,required this.loadingText});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Container(
          decoration: BoxDecoration(
            // color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black,
                AppColors.black,
              ]
            )
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: Get.height * 0.025
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CupertinoActivityIndicator(
                radius: 16,
                color: AppColors.white,
              ),
              (Get.height * 0.025).heightBox(),
              Text(
                loadingText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
