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
              const Text(
                "Assalamualaikum",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GetBuilder<HomeController>(
                builder: (c) {
                  return FutureBuilder<Map<String, dynamic>?>(
                    future: c.getLastRead(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              appLightPurple,
                              appPupleDark,
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                                      children: const [
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
                                    const SizedBox(height: 70),
                                    const Text(
                                      "Loading...",
                                      style: TextStyle(
                                        color: appWhite,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "",
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
                        );
                      }
                      Map<String, dynamic>? lastRead = snapshot.data;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            appLightPurple,
                            appPupleDark,
                          ]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onLongPress: () {
                              if (lastRead != null) {
                                Get.defaultDialog(
                                  title: "Delete Last Read",
                                  middleText: "Are you sure delete bookmark ?",
                                  actions: [
                                    OutlinedButton(
                                        onPressed: () => Get.back(),
                                        child: Text("CANCEL")),
                                    ElevatedButton(
                                        onPressed: () {
                                          c.deleteBookmark(lastRead['id']);
                                          Get.back();
                                        },
                                        child: Text("DELETE")),
                                  ],
                                );
                                //hapus data
                              }
                            },
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              if (lastRead != null) {
                                print(lastRead);
                              }
                            },
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
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
                                        const SizedBox(height: 70),
                                        if (lastRead != null)
                                          Text(
                                            lastRead == null
                                                ? ""
                                                : lastRead['surah']
                                                    .toString()
                                                    .replaceAll("+", "'"),
                                            style: const TextStyle(
                                              color: appWhite,
                                              fontSize: 20,
                                            ),
                                          ),
                                        const SizedBox(height: 5),
                                        Text(
                                          lastRead == null
                                              ? "Belum ada data"
                                              : "Juz ${lastRead['juz']} : | Ayat ${lastRead['ayat']}",
                                          style: const TextStyle(
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
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              const TabBar(
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
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: c.getBookmark(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.data?.length == 0) {
                              return Center(
                                child: Text("Bookmark tidak tersedia"),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data![index];
                                return ListTile(
                                  onTap: () {},
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
                                    data['surah']
                                        .toString()
                                        .replaceAll("+", "'"),
                                  ),
                                  subtitle: Text(
                                    "Ayat ${data['ayat']} - via ${data['via']}",
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      c.deleteBookmark(data["id"]);
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
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
