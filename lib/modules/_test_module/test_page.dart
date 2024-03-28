import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage1 extends StatelessWidget {
  const TestPage1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Ctrl1());
    return Scaffold(
      appBar: AppBar(title: const Text("Page 1"),),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(()=> const TestPage2());
          },
          child: const Text("Go To Page 2"),
        ),
      ),
    );
  }
}


class TestPage2 extends StatelessWidget {
  const TestPage2({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Ctrl2());
    return Scaffold(
      appBar: AppBar(title: const Text("Page 2"),),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(()=> const TestPage3());
          },
          child: const Text("Go To Page 3"),
        ),
      ),
    );
  }
}


class TestPage3 extends StatelessWidget {
  const TestPage3 ({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Ctrl3());
    return Scaffold(
      appBar: AppBar(title: const Text("Page 3"),),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Go back"),
        ),
      ),
    );
  }
}

class Ctrl1 extends GetxController{

}

class Ctrl2 extends GetxController{

}

class Ctrl3 extends GetxController{

}
