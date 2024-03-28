import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skribbl/modules/room/c_room_controller.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (controller) {
        return SizedBox(
          width: double.infinity,
          height: Get.height * 0.05,
          child: const Placeholder(),
        );
      },
    );
  }
}
