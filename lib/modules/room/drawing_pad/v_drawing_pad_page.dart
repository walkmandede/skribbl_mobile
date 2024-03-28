import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/modules/room/drawing_pad/c_drawing_pad_controller.dart';

class DrawingPadPage extends StatelessWidget {
  const DrawingPadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DrawingPadController());
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
