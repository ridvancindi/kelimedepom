import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'db/dbHelper.dart';
import 'models/data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class testspages extends StatefulWidget {
  const testspages({Key? key}) : super(key: key);

  @override
  State<testspages> createState() => _testspagesState();
}

class _testspagesState extends State<testspages> {
  int? error;
  DbHelper? _databaseHelper;
  String? _createdDate;
  void personList;
  final String localJsonPath = 'assets/word/word.json';

  var _response = {
    "everyday": [
      {
        "word": "hafta",
        "opposite": "week",
      },
      {
        "word": "yıl",
        "opposite": "year",
      },
      {
        "word": "bugün",
        "opposite": "today",
      },
      {
        "word": "yarın",
        "opposite": "tomorrow",
      },
      {
        "word": "dün",
        "opposite": "yesterday",
      },
      {
        "word": "takvim",
        "opposite": "calendar",
      },
      {
        "word": "saniye",
        "opposite": "second",
      },
      {
        "word": "saat",
        "opposite": "hour",
      },
      {
        "word": "dakika",
        "opposite": "minute",
      },
      {
        "word": "saat",
        "opposite": "clock",
      },
      {
        "word": "yapabilmek",
        "opposite": "can",
      },
      {
        "word": "kullanmak",
        "opposite": "use",
      },
      {
        "word": "yapmak",
        "opposite": "do",
      },
      {
        "word": "gitmek",
        "opposite": "go",
      },
      {
        "word": "gelmek",
        "opposite": "come",
      },
      {
        "word": "gülmek",
        "opposite": "laugh",
      },
      {
        "word": "yapmak",
        "opposite": "make",
      },
      {
        "word": "görmek",
        "opposite": "see",
      },
      {
        "word": "uzak",
        "opposite": "far",
      },
      {
        "word": "küçük",
        "opposite": "small",
      },
      {
        "word": "iyi",
        "opposite": "good",
      },
      {
        "word": "güzel",
        "opposite": "beautiful",
      },
      {
        "word": "çirkin",
        "opposite": "ugly",
      },
      {
        "word": "zor",
        "opposite": "difficult",
      },
      {
        "word": "kolay",
        "opposite": "easy",
      },
      {
        "word": "kötü",
        "opposite": "bad",
      },
      {
        "word": "yakın",
        "opposite": "near",
      },
      {
        "word": "merhaba",
        "opposite": "hello",
      },
      {
        "word": "pazartesi",
        "opposite": "monday",
      },
      {
        "word": "salı",
        "opposite": "tuesday",
      },
      {
        "word": "çarşamba",
        "opposite": "wednesday",
      },
      {
        "word": "perşembe",
        "opposite": "thursday",
      },
      {
        "word": "cuma",
        "opposite": "friday",
      },
      {
        "word": "cumartesi",
        "opposite": "saturday",
      },
      {
        "word": "pazar",
        "opposite": "sunday",
      },
      {
        "word": "mayıs",
        "opposite": "may",
      },
      {
        "word": "ocak",
        "opposite": "january",
      },
      {
        "word": "şubat",
        "opposite": "february",
      },
      {
        "word": "mart",
        "opposite": "march",
      },
      {
        "word": "nisan",
        "opposite": "april",
      },
      {
        "word": "haziran",
        "opposite": "june",
      },
      {
        "word": "temmuz",
        "opposite": "july",
      },
      {
        "word": "ağustos",
        "opposite": "august",
      },
      {
        "word": "eylül",
        "opposite": "september",
      },
      {
        "word": "ekim",
        "opposite": "october",
      },
      {
        "word": "kasım",
        "opposite": "november",
      },
      {
        "word": "aralık",
        "opposite": "december",
      }
    ]
  };
  void data;
  Future loadLocalJson() async {
    var dummyData = await rootBundle.loadString(localJsonPath);
    return dummyData;
  }

  @override
  void initState() {
    super.initState();
    _databaseHelper = DbHelper();
    loadLocalJson().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    _createdDate = DateFormat('dd-MM-yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text(_response["everyday"]![0]["word"].toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Deneme"),
              onPressed: () {
                EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
                EasyLoading.show(
                    status: 'Ekleniyor...',
                    maskType: EasyLoadingMaskType.black);
                for (var i = 0; i < 10; i++) {
                  i++;
                }
                // for (var i = 0; i < _response["everyday"]!.length; i++) {
                //   addData(
                //       Data(
                //           _response["everyday"]![i]["word"].toString(),
                //           _response["everyday"]![i]["opposite"].toString(),
                //           1,
                //           _createdDate,
                //           null),
                //       _response["everyday"]![i]["word"].toString());
                // }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
                  EasyLoading.showSuccess(
                      '',
                      maskType: EasyLoadingMaskType.black);
                },
                child: Text("data")),
            ElevatedButton(
                onPressed: () {
                  EasyLoading.dismiss();
                },
                child: Text("data"))
          ],
        ),
      ),
    );
  }

  void addData(Data data, String name) async {
    var addNewData = await _databaseHelper!.addData(data, name);
    if (addNewData != 0) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Başarıyla Eklendi");
    } else {
      error = addNewData;
    }
  }
}
