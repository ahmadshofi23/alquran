import 'package:get/get.dart';

import '../controllers/lastread_controller.dart';

class LastreadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LastreadController>(
      () => LastreadController(),
    );
  }
}
