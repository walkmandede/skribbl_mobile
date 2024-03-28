import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/room/c_room_controller.dart';
import 'package:skribbl/services/others/extensions.dart';

class TextFieldPanel extends StatelessWidget {
  const TextFieldPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.txtMsg,
                  decoration: const InputDecoration(
                    hintText: "Type Here ..."
                  ),
                  onTapOutside: (event) {
                    dismissKeyboard();
                  },
                ),
              ),
              10.widthBox(),
              IconButton(
                onPressed: () {
                  controller.onClickSend();
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        );
      },
    );
  }
}
