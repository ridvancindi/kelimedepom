import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'db/dbHelper.dart';
import 'models/data.dart';

class addData extends StatefulWidget {
  addData({Key? key}) : super(key: key);

  @override
  _addDataState createState() => _addDataState();
}

@override
class _addDataState extends State<addData> {
  bool vis = false;
  int? sehir = 1;
  int? error;
  int? num;
  String? _createdDate;
  String? _upgrateDate;
  var _name = TextEditingController();
  var _surname = TextEditingController();
  var _formKey = GlobalKey<FormState>();
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
    // _bannerAd = BannerAd(
    //     size: AdSize.mediumRectangle,
    //     adUnitId: AdHelper.bannerAdUnitId,
    //     listener: BannerAdListener(onAdLoaded: (_) {
    //       setState(() {
    //         _isBanneradReady = true;
    //       });
    //     }, onAdFailedToLoad: (ad, error) {
    //       print("Error = ${error.message}");
    //       _isBanneradReady = false;
    //       ad.dispose();
    //     }),
    //     request: AdRequest())
    //   ..load();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    _createdDate = DateFormat('dd-MM-yyyy').format(now);
    _upgrateDate = DateFormat('dd-MM-yyyy').format(now);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "editdata.appbar1".tr(),
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.chevron_left_rounded)),
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
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
                                controller: _name,
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
                                controller: _surname,
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
                                  labelText: "editdata.input2".tr(),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                            if (_formKey.currentState!.validate()) {
                              addData(
                                  Data(_name.text, _surname.text, 1,
                                      _createdDate, null),
                                  _name.text);
                            } else {}
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // if (_isBanneradReady == true)
                  //   Container(
                  //     width: _bannerAd.size.width.toDouble(),
                  //     height: _bannerAd.size.height.toDouble(),
                  //     child: AdWidget(ad: _bannerAd),
                  //   )
                ],
              ),
            ),
          ]))),
    );
  }

  void addData(Data data, String name) async {
    var addNewData = await _databaseHelper!.addData(data, name);
    if (addNewData != 0) {
      Navigator.of(context).pop(true);
    } else {
      error = addNewData;
    }
  }
}
