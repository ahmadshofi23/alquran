import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/detail_surah.dart' as detail;
import '../controllers/detail_suurah_controller.dart';

class DetailSuurahView extends GetView<DetailSuurahController> {
  @override
  Widget build(BuildContext context) {
    final Surah surah = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('SURAH ${surah.name!.transliteration!.id!.toUpperCase()}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: (() => Get.defaultDialog(
                  backgroundColor: Get.isDarkMode
                      ? appLightPurple.withOpacity(0.8)
                      : appWhite,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          const SizedBox(height: 20),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("Tidak ada data..."),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data?.verses?.length == 0) {
                    return const SizedBox();
                  }
                  detail.Verse? ayat = snapshot.data?.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                                child: Center(child: Text("${index + 1}")),
                              ),
                              GetBuilder<DetailSuurahController>(
                                builder: (c) => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.bookmark_add_outlined),
                                    ),
                                    (ayat?.kondisiAudio == "stop")
                                        ? IconButton(
                                            onPressed: () {
                                              c.playAudio(ayat);
                                            },
                                            icon: const Icon(Icons.play_arrow),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              (ayat?.kondisiAudio == "playing")
                                                  ? IconButton(
                                                      onPressed: () {
                                                        c.pauseAudio(ayat);
                                                      },
                                                      icon: const Icon(
                                                          Icons.pause),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        c.resumeAudio(ayat!);
                                                      },
                                                      icon: const Icon(
                                                          Icons.play_arrow),
                                                    ),
                                              IconButton(
                                                onPressed: () {
                                                  c.stopAudio(ayat!);
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${ayat!.text?.arab}",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "Artinya : ${ayat.translation!.id}",
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
              );
            },
          ),
        ],
      ),
    );
  }
}
