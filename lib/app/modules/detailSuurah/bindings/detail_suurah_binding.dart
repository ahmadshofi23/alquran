import 'package:get/get.dart';

import '../controllers/detail_suurah_controller.dart';

class DetailSuurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSuurahController>(
      () => DetailSuurahController(),
    );
  }
}
