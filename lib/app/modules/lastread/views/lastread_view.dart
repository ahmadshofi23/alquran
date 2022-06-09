import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lastread_controller.dart';

class LastreadView extends GetView<LastreadController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LastreadView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LastreadView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
