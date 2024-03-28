import 'package:flutter/material.dart';
import 'package:skribbl/services/others/extensions.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/app_functions.dart';
import '../dialog_service.dart';

class TransactionDialog extends StatelessWidget {
  final String text;
  final Function() onClickYes;
  final Function() onClickNo;
  final String yesButtonText;
  final String noButtonText;
  const TransactionDialog({
    super.key,
    this.text = "Are you suer?",
    required this.onClickYes,
    required this.onClickNo,
    this.yesButtonText = "Continue",
    this.noButtonText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgSoftGrey,
            borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white
                ),
              ),
              10.heightBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      vibrateNow();
                      onClickNo();
                      DialogService().dismissDialog();
                    },
                    child: Text(noButtonText,style: TextStyle(color: AppColors.red),),
                  ),
                  TextButton(
                    onPressed: () {
                      vibrateNow();
                      onClickYes();
                      DialogService().dismissDialog();
                    },
                    child: Text(yesButtonText,style: TextStyle(color: AppColors.blue),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
