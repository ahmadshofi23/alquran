import 'dart:convert';

import 'package:alquran/app/data/models/juz.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constant/color.dart';
import '../../../data/models/detail_surah.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool isDarkMode = false.obs;

  //list untuk mengambil surah apa saja yang ada dalam satu jus
  List<Surah> allSurah = [];
  void changeThemeMode() async {
    final box = GetStorage();

    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDarkMode.toggle();

    if (Get.isDarkMode) {
      //dark -> light
      box.remove("themeDark");
    } else {
      box.write("themeDark", true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
    var res = await http.get(url);
    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;
    List<Map<String, dynamic>> penampungAyat = [];
    List<Map<String, dynamic>> allJuz = [];
    for (var i = 0; i <= 114; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));

      Map<String, dynamic> rawData = json.decode(res.body)["data"];
      DetailSurah data = DetailSurah.fromJson(rawData);

      if (data.verses != null) {
        data.verses!.forEach((ayat) {
          if (ayat.meta!.juz == juz) {
            penampungAyat.add({
              "surah": data,
              "ayat": ayat,
            });
          } else {
            // print("=======");
            // print("Berhasil memasukkan Juz $juz");
            // print("START : ");
            // print((penampungAyat[0]["ayat"] as Verse).number!.inSurah);
            // print("END :");
            // print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)
            //     .number!
            //     .inSurah);
            allJuz.add({
              "juz": juz,
              "start": penampungAyat[0],
              "end": penampungAyat[penampungAyat.length - 1],
              "verses": penampungAyat,
            });
            juz++;
            penampungAyat = [];
            penampungAyat.add({
              "surah": data,
              "ayat": ayat,
            });
          }
        });
      }
    }
    // print("=======");
    // print("Berhasil memasukkan Juz $juz");
    // print("START : ");
    // print((penampungAyat[0]["ayat"] as Verse).number!.inSurah);
    // print("END :");
    // print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)
    //     .number!
    //     .inSurah);
    allJuz.add({
      "juz": juz,
      "start": penampungAyat[0],
      "end": penampungAyat[penampungAyat.length - 1],
      "verses": penampungAyat,
    });

    return allJuz;

    // List<Juz> allJuz = [];
    // for (int i = 1; i <= 30; i++) {
    //   Uri url = Uri.parse("https://api.quran.sutanlab.id/juz/$i");
    //   var res = await http.get(url);
    //   Map<String, dynamic> data =
    //       (json.decode(res.body) as Map<String, dynamic>)["data"];

    //   Juz juz = Juz.fromJson(data);
    //   allJuz.add(juz);
    // }

    // // print(data);
    // return allJuz;
  }
}
