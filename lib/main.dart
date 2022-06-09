import 'package:alquran/app/constant/color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: box.read("themeDark") == null ? themeLight : themeDark,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
