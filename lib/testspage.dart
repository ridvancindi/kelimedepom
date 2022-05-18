import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admobHelper.dart';
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
  List? everyday;
  List? foodanddring;
  List? healthandbody;
  List? works;
  Future<void> loadLocalJson() async {
    final String response = await rootBundle.loadString(localJsonPath);
    final data = await json.decode(response);
    setState(() {
      everyday = data["everyday"];
      foodanddring = data["foodanddring"];
      healthandbody = data["healthandbody"];
      works = data["works"];
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocalJson();
    _databaseHelper = DbHelper();
    // loadLocalJson().then((value) {
    //   setState(() {
    //     data = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    _createdDate = DateFormat('dd-MM-yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelime Paketleri"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  onPressed: () {
                    for (var i = 0; i < everyday!.length; i++) {
                      addData(
                          Data(
                              everyday![i]["word"].toString(),
                              everyday![i]["opposite"].toString(),
                              1,
                              _createdDate,
                              null),
                          everyday![i]["word"].toString());
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff1be9dc), Color(0xff337af8)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity, minHeight: 60.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Günlük Kullanılan Kelimeler (47 Kelime)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  onPressed: () {
                    for (var i = 0; i < foodanddring!.length; i++) {
                      addData(
                          Data(
                              foodanddring![i]["word"].toString(),
                              foodanddring![i]["opposite"].toString(),
                              1,
                              _createdDate,
                              null),
                          foodanddring![i]["word"].toString());
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 103, 241, 115),
                            Color.fromARGB(255, 5, 199, 44)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity, minHeight: 60.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Yemekler Ve İçecekler (9 Kelime)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
             Container(
                 height: 60,
                 alignment: Alignment.center,
                 child: AdWidget(
                   key: UniqueKey(),
                   ad: AdHelper.createBannerAd()..load(),
                 )),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  onPressed: () {
                    for (var i = 0; i < healthandbody!.length; i++) {
                      addData(
                          Data(
                              healthandbody![i]["word"].toString(),
                              healthandbody![i]["opposite"].toString(),
                              1,
                              _createdDate,
                              null),
                          healthandbody![i]["word"].toString());
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 241, 103, 103),
                            Color.fromARGB(255, 199, 5, 37)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity, minHeight: 60.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Vücut Parçaları (9 Kelime)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  onPressed: () {
                    for (var i = 0; i < works!.length; i++) {
                      addData(
                          Data(
                              works![i]["word"].toString(),
                              works![i]["opposite"].toString(),
                              1,
                              _createdDate,
                              null),
                          works![i]["word"].toString());
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 163, 103, 241),
                            Color.fromARGB(255, 95, 5, 199)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity, minHeight: 60.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Meslekler (9 Kelime)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  void addData(Data data, String name) async {
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.show(
        status: 'Ekleniyor...', maskType: EasyLoadingMaskType.black);
    var addNewData = await _databaseHelper!.addData(data, name);
    if (addNewData != 0) {
      EasyLoading.showSuccess("Başarıyla Eklendi");
    } else {
      error = addNewData;
    }
  }
}
