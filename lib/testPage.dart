import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelimedepom/db/dbHelper.dart';
import 'package:kelimedepom/questionPage.dart';
import 'package:kelimedepom/quiz.dart';

import 'admobHelper.dart';
import 'models/data.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  List<Data>? data;
  DbHelper? _databaseHelper;
  int pasif = 0;
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DbHelper();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      data = <Data>[];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "homepage.test".tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60.0,
              child: RaisedButton(
                onPressed: () async {
                  if (data!.length - pasif >= 4) {
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizPage(data!)),
                    );
                  } else {
                    final snackBar = SnackBar(
                      content: Text("homepage.message1".tr()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffb421f3), Color(0xffde4482)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 60.0),
                    alignment: Alignment.center,
                    child: Text(
                      "homepage.quiz".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60.0,
              child: RaisedButton(
                onPressed: () {
                  if (data!.length - pasif >= 4) {
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => questionPage(data!)),
                    );
                  } else {
                    final snackBar = SnackBar(
                      content: Text("homepage.message1".tr()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 60.0),
                    alignment: Alignment.center,
                    child: Text(
                      "homepage.question".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 270,
              alignment: Alignment.center,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdHelper.createlargeBannerAd()..load(),
              ))
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 60.0,
          //     child: RaisedButton(
          //       onPressed: () {

          //       },
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(80.0)),
          //       padding: EdgeInsets.all(0.0),
          //       child: Ink(
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(
          //               colors: [Color(0xff1be9dc), Color(0xff337af8)],
          //               begin: Alignment.centerLeft,
          //               end: Alignment.centerRight,
          //             ),
          //             borderRadius: BorderRadius.circular(30.0)),
          //         child: Container(
          //           constraints: BoxConstraints(
          //               maxWidth: double.infinity, minHeight: 60.0),
          //           alignment: Alignment.center,
          //           child: Text(
          //             "homepage.question".tr(),
          //             textAlign: TextAlign.center,
          //             style: TextStyle(color: Colors.white, fontSize: 16.5),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void getData() {
    int _pasif = 0;
    int _addDaily = 0;
    int _upgrateDaily = 0;
    var dbFuture = _databaseHelper!.initializeDatabase();
    dbFuture.then((value) {
      var proFuture = _databaseHelper!.allData();
      proFuture.then((value) {
        List<Data> productsData = [];
        count = value.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Data.dbdenOkunanDeger(value[i]));
        }
        for (var i = 0; i < productsData.length; i++) {
          if (productsData[i].isActive == 0) {
            _pasif++;
          }
        }
        setState(() {
          pasif = _pasif;
          data = productsData;
          count = count;
        });
      });
    });
  }
}
