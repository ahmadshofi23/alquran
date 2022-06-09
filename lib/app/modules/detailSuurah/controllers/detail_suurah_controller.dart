import 'dart:async';
import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSuurahController extends GetxController {
  //TODO: Implement DetailSuurahController
  // RxString kondisiAudio = "stop".obs;
  final player = AudioPlayer();
  Verse? lasVerse;

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    // DetailSurah test = DetailSurah.fromJson(data);

    // print(test);

    return DetailSurah.fromJson(data);
  }

  void stopAudio(Verse ayat) async {
    try {
      //
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();

      //

    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat pause audio",
      );
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      //
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();

      //

    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat pause audio",
      );
    }
  }

  void pauseAudio(Verse? ayat) async {
    try {
      //
      await player.pause();
      ayat!.kondisiAudio = "pause";
      update();

      //

    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat pause audio",
      );
    }
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      //process
      try {
        //
        if (lasVerse == null) {
          lasVerse = ayat;
        }
        lasVerse!.kondisiAudio = "stop";
        update();
        lasVerse = ayat;
        lasVerse!.kondisiAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        update();
        await player.stop();

        //

      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat memutar audio",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "URL Audio tidak dapat diproses",
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    player.stop();
    player.dispose();
    super.onClose();
  }
}
