import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_colors.dart';
import 'package:skribbl/constants/app_constants.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/room/c_room_controller.dart';
import 'package:skribbl/modules/room/playground/sub_widgets/w_board_widget.dart';
import 'package:skribbl/modules/room/playground/sub_widgets/w_message_box_widget.dart';
import 'package:skribbl/modules/room/playground/sub_widgets/w_players_sector.dart';
import 'package:skribbl/modules/room/playground/sub_widgets/w_text_field_panel.dart';
import 'package:skribbl/modules/room/playground/sub_widgets/w_top_bar.dart';
import 'package:skribbl/services/others/extensions.dart';

class PlaygroundPage extends StatefulWidget {
  final String roomCode;
  const PlaygroundPage({super.key,required this.roomCode});

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {


  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  void dispose() {
    try{
      Get.delete<RoomController>();
    }
    catch(e){
      null;
    }
    super.dispose();
  }

  Future<void> initLoad() async{
    final controller = Get.put(RoomController());
    controller.initLoad(roomCode: widget.roomCode);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: GetBuilder<RoomController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: ValueListenableBuilder(
                valueListenable: controller.currentRoomCode,
                builder: (context, roomCode, child) {
                  return Text(
                    "Room Code : $roomCode",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppConstants.fontSizeXL
                    ),
                  );
                },
              ),
            ),
            body: SizedBox.expand(
              child: Column(
                children: [
                  TopBar(),
                  AspectRatio(
                    aspectRatio: 2/1,
                    child: BoardWidget(),
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        controller.currentPage.value = value;
                        controller.currentPage.notifyListeners();
                      },
                      children: [
                        MessageBox(),
                        PlayersSector()
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.currentPage,
                    builder: (context, currentPage, child) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: currentPage==index?AppColors.black:AppColors.grey,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  TextFieldPanel(),
                  (Get.mediaQuery.padding.bottom).heightBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
