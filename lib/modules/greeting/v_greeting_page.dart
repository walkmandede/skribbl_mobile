import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_constants.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/_common/controllers/c_data_controller.dart';
import 'package:skribbl/modules/_common/loading/v_loading_page.dart';
import 'package:skribbl/modules/greeting/c_greeting_controller.dart';
import 'package:skribbl/services/others/extensions.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GreetingController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome To Skribbl",
          style: TextStyle(
            color: Colors.white,
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w900
          ),
        ),
      ),
      body: SizedBox.expand(
        child: ValueListenableBuilder(
          valueListenable: controller.xLoading,
          builder: (context, xLoading, child) {
            if(xLoading){
              return const LoadingPage();
            }
            else{
              return Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.basePadding,
                  vertical: AppConstants.basePadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: controller.txtName,
                      decoration: const InputDecoration(
                        labelText: "Enter Your Name"
                      ),
                      onTapOutside: (event) {
                        dismissKeyboard();
                      },
                    ),
                    20.heightBox(),
                    SizedBox(
                      width: double.infinity,
                      height: AppConstants.baseButtonHeightM,
                      child: ElevatedButton(
                        onPressed: () {
                          vibrateNow();
                          controller.onClickNext();
                        },
                        child: const Text(
                          "Next"
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

