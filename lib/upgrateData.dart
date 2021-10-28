import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:easy_localization/easy_localization.dart';
import 'admobHelper.dart';
import 'db/dbHelper.dart';
import 'models/data.dart';

class upgrateData extends StatefulWidget {
  Data data;
  upgrateData(this.data);

  @override
  _upgrateDataState createState() => _upgrateDataState(data);
}

class _upgrateDataState extends State<upgrateData> {
  Data? data;
  late BannerAd _bannerAd;
  bool _isBanneradReady = false;
  _upgrateDataState(this.data);
  var _kelime = TextEditingController();
  var _karsilik = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  int? error;
  String? name;
  DbHelper? _databaseHelper;
  List<Data>? allData;
  @override
  void initState() {
    super.initState();
    allData = <Data>[];
    _databaseHelper = DbHelper();
    _databaseHelper!.allData().then((allStudentMapList) {
      for (Map<String, dynamic> okunanStudentMap in allStudentMapList) {
        allData!.add(Data.dbdenOkunanDeger(okunanStudentMap));
      }
      setState(() {});
    }).catchError((hata) => print("Hata $hata"));
    _kelime.text = data!.kelime;
    _karsilik.text = data!.karsilik;
    _bannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBanneradReady = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print("Error = ${error.message}");
          _isBanneradReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "editdata.appbar".tr(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Visibility(
                        visible: error != 0 ? false : true,
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              children: [
                                Text(
                                  "editdata.error3".tr(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ))),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            child: TextFormField(
                                controller: _kelime,
                                keyboardType: TextInputType.name,
                                style: TextStyle(fontSize: 15),
                                autofocus: false,
                                validator: (kontroledilecekname) {
                                  if (kontroledilecekname!.isEmpty) {
                                    return "editdata.error1".tr();
                                  } else if (kontroledilecekname.length < 2) {
                                    return "editdata.error2".tr();
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  labelText: "editdata.input1".tr(),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            child: TextFormField(
                                controller: _karsilik,
                                keyboardType: TextInputType.name,
                                style: TextStyle(fontSize: 15),
                                autofocus: false,
                                validator: (kontroledilecekname) {
                                  if (kontroledilecekname!.isEmpty) {
                                    return "editdata.error1".tr();
                                  } else if (kontroledilecekname.length < 2) {
                                    return "editdata.error1".tr();
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  labelText: "editdata.input2".tr(),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                            child: Text(
                              "editdata.save".tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  _upgrateData(
                                      Data.withId(
                                          data!.id,
                                          _kelime.text,
                                          _karsilik.text,
                                          1,
                                          data!.createdDate,
                                          data!.upgrateDate),
                                      _kelime.text);
                                } else {}
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (_isBanneradReady == true)
                      Container(
                        width: _bannerAd.size.width.toDouble(),
                        height: _bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd),
                      )
                  ],
                ),
              ),
            ]))));
  }

  void _upgrateData(Data data, String name) async {
    var sonuc = await _databaseHelper!.dataUpgrate(data, name);
    if (sonuc != 0) {
      print("1");
      Navigator.of(context).pop(true);
    } else {
      error = sonuc;
    }
  }
}
