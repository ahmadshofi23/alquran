// import 'dart:convert';

// import 'package:alquran/app/data/models/detail_surah.dart';
// import 'package:alquran/app/data/models/surah.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   Future<DetailSurah> getDetailSurah(String id) async {
//     Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/$id");
//     var res = await http.get(url);

//     Map<String, dynamic> data =
//         (json.decode(res.body) as Map<String, dynamic>)["data"];
//     DetailSurah test = DetailSurah.fromJson(data);

//     print(test);
//   }

//   await getDetailSurah(1.toString());
// //   Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
// //   var res = await http.get(url);
// //   List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

// //   // print(data[113]);

// //   //data dari api -> Model
// //   Surah surahAnnas = Surah.fromJson(data[113]);
// //   // print(surahAnnas.name?.long);
// //   // print(surahAnnas.number);

// //   Uri urlAnnas =
// //       Uri.parse("https://api.quran.sutanlab.id/surah/${surahAnnas.number}");
// //   var resAnnas = await http.get(urlAnnas);

// //   Map<String, dynamic> dataAnnas =
// //       (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];

// //   DetailSurah detailSurahAnnas = DetailSurah.fromJson(dataAnnas);
// //   print(detailSurahAnnas.verses![0].text!.arab);
// }

// import 'dart:convert';

// import 'package:alquran/app/data/models/ayat.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   var res =
//       await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/108/1"));
//   Map<String, dynamic> data = json.decode(res.body)["data"];
//   Map<String, dynamic> dataToModel = {
//     "number": data["number"],
//     "meta": data["meta"],
//     "text": data["text"],
//     "translation": data["translation"],
//     "audio": data["audio"],
//     "tafsir": data["tafsir"],
//   };
//   // print(data);

//   //convert Map -> model ayat
//   Ayat ayat = Ayat.fromJson(dataToModel);
// }

// import 'dart:convert';

// import 'package:alquran/app/data/models/detail_surah.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   // int juz = 1;
//   // List<Map<String, dynamic>> penampungAyat = [];
//   // List<Map<String, dynamic>> allJuz = [];
//   // for (var i = 0; i <= 114; i++) {
//   //   var res =
//   //       await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));

//   //   Map<String, dynamic> rawData = json.decode(res.body)["data"];
//   //   DetailSurah data = DetailSurah.fromJson(rawData);

//   //   if (data.verses != null) {
//   //     data.verses!.forEach((ayat) {
//   //       if (ayat.meta!.juz == juz) {
//   //         penampungAyat.add({
//   //           "surah": data.name?.transliteration?.id ?? '',
//   //           "ayat": ayat,
//   //         });
//   //       } else {
//   //         print("=======");
//   //         print("Berhasil memasukkan Juz $juz");
//   //         print("START : ");
//   //         print((penampungAyat[0]["ayat"] as Verse).number!.inSurah);
//   //         print("END :");
//   //         print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)
//   //             .number!
//   //             .inSurah);
//   //         allJuz.add({
//   //           "juz": juz,
//   //           "start": penampungAyat[0],
//   //           "end": penampungAyat[penampungAyat.length - 1],
//   //           "verses": penampungAyat,
//   //         });
//   //         juz++;
//   //         penampungAyat.clear();
//   //         penampungAyat.add({
//   //           "surah": data.name?.transliteration?.id ?? '',
//   //           "ayat": ayat,
//   //         });
//   //       }
//   //     });
//   //   }
//   // }
//   // print("=======");
//   // print("Berhasil memasukkan Juz $juz");
//   // print("START : ");
//   // print((penampungAyat[0]["ayat"] as Verse).number!.inSurah);
//   // print("END :");
//   // print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)
//   //     .number!
//   //     .inSurah);
//   // allJuz.add({
//   //   "juz": juz,
//   //   "start": penampungAyat[0],
//   //   "end": penampungAyat[penampungAyat.length - 1],
//   //   "verses": penampungAyat,
//   // });
// }
