import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skribbl/constants/app_constants.dart';
import 'package:skribbl/modules/room/c_room_controller.dart';

class PlayersSector extends StatelessWidget {
  const PlayersSector({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (controller) {
        return ValueListenableBuilder(
          valueListenable: controller.playersList,
          builder: (context, playerList, child) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.basePadding,
                vertical: AppConstants.basePadding
              ),
              child: Column(
                children: [
                  ...playerList.map((e) {
                    return ListTile(
                      title: Text(
                        e.name
                      ),
                      trailing: Text("${e.point.toString()} Pts"),
                    );
                  }).toList()
                ],
              ),
            );
          },
        );
      },
    );
  }
}
