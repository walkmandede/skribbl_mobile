import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skribbl/constants/app_colors.dart';
import 'package:skribbl/constants/app_constants.dart';
import 'package:skribbl/modules/room/c_room_controller.dart';
import 'package:skribbl/services/others/extensions.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: AppConstants.basePadding,
              vertical: AppConstants.basePadding
          ),
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.basePadding,
              vertical: AppConstants.basePadding
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
          ),
          child: ValueListenableBuilder(
            valueListenable: controller.messagesList,
            builder: (context, messageList, child) {
              if(messageList.isEmpty){
                return const Center(
                  child: Text("No Message Yet!"),
                );
              }
              else{
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final message = messageList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.inGamePlayer.name,
                          style: TextStyle(
                              color: AppColors.grey,
                              fontSize: AppConstants.fontSizeXS
                          ),
                        ),
                        Text(
                          message.message,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: AppConstants.fontSizeM
                          ),
                        ),
                        5.heightBox(),
                        const Divider(),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
