import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  final homeController = Get.find<HomeController>();

  //get argument untuk mengambil data surah apa saja dalam 1 juz
  // final List<Surah> allSurahInThisJuz = Get.arguments["surah"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${dataMapPerJuz["juz"]}'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: (dataMapPerJuz["verses"] as List).length,
            itemBuilder: (context, index) {
              if ((dataMapPerJuz["verses"] as List).length == 0) {
                return Center(
                  child: Text("Tidak ada data..."),
                );
              }

              Map<String, dynamic> ayat = dataMapPerJuz["verses"][index];

              detail.DetailSurah surah = ayat["surah"];
              detail.Verse verse = ayat["ayat"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (verse.number?.inSurah == 1)
                    GestureDetector(
                      onTap: (() => Get.defaultDialog(
                            backgroundColor: Get.isDarkMode
                                ? appLightPurple.withOpacity(0.8)
                                : appWhite,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            title: "TAFSIR ${surah.name!.transliteration!.id}",
                            titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            content: Container(
                              child: Text(
                                "${surah.tafsir!.id} ?? 'Tidak ada tafsir pada surah ini'",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          )),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              appLightPurple,
                              appPupleDark,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "${surah.name!.transliteration!.id!.toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: appWhite,
                                ),
                              ),
                              Text(
                                "{${surah.name!.translation!.id}}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: appWhite,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${surah.numberOfVerses} Ayat | ${surah.revelation!.id}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: appWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: appLightGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/list.png",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                    child: Text("${verse.number!.inSurah}")),
                              ),
                              Text(
                                " ${surah.name!.transliteration!.id}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<DetailJuzController>(
                            builder: (c) => Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "BOOKMARK",
                                      middleText: "Pilih jenis bookmark",
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await controller.addBookmark(
                                                true, surah, verse, index);
                                            homeController.update();
                                          },
                                          child: const Text("LAST READ"),
                                          style: ElevatedButton.styleFrom(
                                            primary: appPurple,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.addBookmark(
                                                false, surah, verse, index);
                                          },
                                          child: Text("BOOKMARK"),
                                          style: ElevatedButton.styleFrom(
                                            primary: appPurple,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  icon: const Icon(Icons.bookmark_add_outlined),
                                ),
                                (verse.kondisiAudio == "stop")
                                    ? IconButton(
                                        onPressed: () {
                                          c.playAudio(verse);
                                        },
                                        icon: const Icon(Icons.play_arrow),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (verse.kondisiAudio == "playing")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.pauseAudio(verse);
                                                  },
                                                  icon: const Icon(Icons.pause),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    c.resumeAudio(verse);
                                                  },
                                                  icon: const Icon(
                                                      Icons.play_arrow),
                                                ),
                                          IconButton(
                                            onPressed: () {
                                              c.stopAudio(verse);
                                            },
                                            icon: const Icon(
                                              Icons.stop,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "${(ayat['ayat'] as detail.Verse).text!.arab}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "Artinya : ${(ayat['ayat'] as detail.Verse).translation!.id}",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
