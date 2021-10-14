import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelimedepom/quizFinish.dart';
import 'package:easy_localization/easy_localization.dart';
import 'admobHelper.dart';
import 'models/data.dart';

class QuizPage extends StatefulWidget {
  List<Data> data;
  QuizPage(this.data);
  @override
  _QuizPageState createState() => _QuizPageState(data);
}

class _QuizPageState extends State<QuizPage> {
  late BannerAd _bannerAd;
  bool _isBanneradReady = false;
  @override
  void initState() {
    super.initState();
    Body();
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

  List<Data> data;
  _QuizPageState(this.data);
  List question = [];
  var falseQuestion = <Map<String, dynamic>>[];
  int id = 0;
  var _formKey = GlobalKey<FormState>();
  var _reply = TextEditingController();
  int trueNum = 0;
  int falseNum = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("quiz.appbar".tr()),
            automaticallyImplyLeading: false,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                quizFinish(falseQuestion, trueNum, falseNum)),
                      );
                    },
                    icon: Icon(Icons.exit_to_app_outlined)),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "quiz.word".tr() +  ": ${question[id].kelime}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                          controller: _reply,
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontSize: 15),
                          autofocus: false,
                          validator: (kontroledilecekname) {
                            if (kontroledilecekname!.isEmpty) {
                              return "quiz.error".tr();
                            } else if (kontroledilecekname !=
                                question[id].karsilik) {
                              falseQuestion.add({
                                "kelime": question[id].kelime,
                                "karsilik": question[id].karsilik,
                                "hata": _reply.text
                              });
                              falseNum++;
                              return null;
                            } else if (kontroledilecekname ==
                                question[id].karsilik) {
                              trueNum++;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            labelText: "quiz.input".tr(),
                          )),
                    )),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          if (id == question.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => quizFinish(
                                      falseQuestion, trueNum, falseNum)),
                            );
                          } else {
                            _reply.clear();
                            id++;
                          }
                        }
                      });
                    },
                    child:
                        Text(id != question.length - 1 ? "quiz.skip".tr() : "quiz.final".tr())),
              ),
              SizedBox(
                height: 15,
              ),
              if (_isBanneradReady == true)
                Center(
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                )
            ],
          ),
        ));
  }

  Body() {
    for (var i = 0; i < data.length; i++) {
      if (data[i].isActive == 1) {
        question.add(data[i]);
      }
    }
  }
}
