import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/surah.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDarkMode.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Al-Quran Apps'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    appLightPurple,
                    appPupleDark,
                  ]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Get.toNamed(Routes.LASTREAD),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -50,
                            right: 0,
                            child: Opacity(
                              opacity: 0.6,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  "assets/images/alquran.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Terakhir dibaca",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 70),
                                Text(
                                  "Al-Fatihah",
                                  style: TextStyle(
                                    color: appWhite,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Juz 1 : | Ayat 7",
                                  style: TextStyle(
                                    color: appWhite,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TabBar(
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Juz",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Tidak ada data..."),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SUURAH,
                                    arguments: surah);
                              },
                              leading: Obx(
                                () => Container(
                                  height: 40,
                                  width: 40,
                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.isDarkMode.isTrue
                                            ? "assets/images/list.png"
                                            : "assets/images/list.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${surah.number}",
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${surah.name?.transliteration?.id ?? 'Error...'}",
                              ),
                              subtitle: Text(
                                "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Error...'}",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Text(
                                "${surah.name!.long ?? 'Error...'}",
                              ),
                            );
                          },
                        );
                      },
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Tidak ada data..."),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataMapPerJuz =
                                snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_JUZ,
                                    arguments: dataMapPerJuz);
                              },
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/list.png",
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                  ),
                                ),
                              ),
                              title: Text(
                                "Juz ${index + 1}",
                              ),
                              isThreeLine: true,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Mulai : ${(dataMapPerJuz['start']['surah'] as detail.DetailSurah).name!.transliteration!.id} ayat ${(dataMapPerJuz['start']['ayat'] as detail.Verse).number?.inSurah}",
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                  Text(
                                    "Sampai : ${(dataMapPerJuz['end']['surah'] as detail.DetailSurah).name!.transliteration!.id} ayat ${(dataMapPerJuz['end']['ayat'] as detail.Verse).number?.inSurah}",
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    // FutureBuilder<List<juz.Juz>>(
                    //   future: controller.getAllJuz(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //     if (!snapshot.hasData) {
                    //       return Center(
                    //         child: Text("Tidak ada data..."),
                    //       );
                    //     }

                    //     return ListView.builder(
                    //       itemCount: snapshot.data!.length,
                    //       itemBuilder: (context, index) {
                    //         juz.Juz detailJuz = snapshot.data![index];
                    //         //untuk mengambil surah apa saja dalam juz
                    //         //karena endpoint APi terbatas
                    //         String nameStart =
                    //             detailJuz.start!.split(" - ").first;
                    //         String nameEnd = detailJuz.end!.split(" - ").first;

                    //         List<Surah> rawAllSurahInJus = [];
                    //         List<Surah> allSurahInJus = [];

                    //         for (Surah item in controller.allSurah) {
                    //           rawAllSurahInJus.add(item);
                    //           if (item.name!.transliteration!.id == nameEnd) {
                    //             break;
                    //           }
                    //         }

                    //         for (Surah item
                    //             in rawAllSurahInJus.reversed.toList()) {
                    //           allSurahInJus.add(item);
                    //           if (item.name!.transliteration!.id == nameStart) {
                    //             break;
                    //           }
                    //         }

                    //         //sampai sini

                    //         return ListTile(
                    //           onTap: () {
                    //             Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                    //               "juz": detailJuz,
                    //               "surah": allSurahInJus.reversed.toList(),
                    //             });
                    //           },
                    //           leading: Container(
                    //             height: 40,
                    //             width: 40,
                    //             decoration: BoxDecoration(
                    //               image: DecorationImage(
                    //                 image: AssetImage(
                    //                   "assets/images/list.png",
                    //                 ),
                    //               ),
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 "${index + 1}",
                    //               ),
                    //             ),
                    //           ),
                    //           title: Text(
                    //             "Juz ${index + 1}",
                    //           ),
                    //           isThreeLine: true,
                    //           subtitle: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Text(
                    //                 "Mulai : ${detailJuz.start}",
                    //                 style: TextStyle(color: Colors.grey[500]),
                    //               ),
                    //               Text(
                    //                 "Sampai : ${detailJuz.end}",
                    //                 style: TextStyle(color: Colors.grey[500]),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    Text("Page 3"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeThemeMode(),
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDarkMode.isTrue ? appPupleDark : appWhite,
          ),
        ),
      ),
    );
  }
}
