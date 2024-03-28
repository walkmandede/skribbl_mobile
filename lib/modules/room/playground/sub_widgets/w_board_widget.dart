import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skribbl/modules/room/c_room_controller.dart';
import 'package:skribbl/modules/room/drawing_pad/v_drawing_pad_page.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(()=> const DrawingPadPage());
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all()
            ),
          ),
        );
      },
    );
  }
}
