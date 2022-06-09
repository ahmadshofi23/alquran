import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  //get argument untuk mengambil data surah apa saja dalam 1 juz
  // final List<Surah> allSurahInThisJuz = Get.arguments["surah"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${dataMapPerJuz["juz"]}'),
        centerTitle: true,
      ),
      body: ListView.builder(
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if ((ayat["ayat"] as detail.Verse).number?.inSurah == 1)
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                child: Text(
                                    "${(ayat['ayat'] as detail.Verse).number!.inSurah}")),
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
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_add_outlined),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                          ),
                        ],
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
    );
  }
}
