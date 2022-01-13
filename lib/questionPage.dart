import 'dart:async';
import 'dart:math';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelimedepom/questionFinish.dart';
import 'admobHelper.dart';
import 'models/data.dart';

class questionPage extends StatefulWidget {
  List<Data> data;
  questionPage(this.data);
  @override
  _questionPageState createState() => _questionPageState(data);
}

class _questionPageState extends State<questionPage> {
  List<Data> data;
  _questionPageState(this.data);
  List question = [];
  int pasif = 0;
  int id = 0;
  int count = 0;
  int i = 2;
  bool disableAnswer = false;
  // extra varibale to iterate
  var random_array;
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int tureQuiz = 0;
  int wrongQuiz = 0;
  Icon? icon;
  Icon wrongIcon = Icon(Icons.close);
  Icon trueIcons = Icon(
    Icons.check,
    size: 25,
  );

  Map<String, Color> btncolor = {
    "A": Colors.black12,
    "B": Colors.black12,
    "C": Colors.black12,
    "D": Colors.black12,
  };
  Map<String, dynamic> btntrue = {
    "A": true,
    "B": true,
    "C": true,
    "D": true,
  };
  List questions = [];
  InterstitialAd? _interstitialAd;
  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          _createInterstitialAd();
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInterstitialAd();
    Body();
    cevaplar(id);
    genrandomarray(id);
  }

  void checkanswer(String k, int num) {
    // in the previous version this was
    // mydata[2]["1"] == mydata[1]["1"][k]
    // which i forgot to change
    // so nake sure that this is now corrected
    if (questions[num] == question[id].karsilik) {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
      marks = marks + 5;
      // changing the color variable to be green
      colortoshow = right;
      tureQuiz++;
      icon = trueIcons;
    } else {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
      colortoshow = wrong;
      icon = wrongIcon;
      wrongQuiz++;
    }
    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;
      btntrue[k] = !btntrue[k];
      disableAnswer = true;
    });
  }

  bool _enabled = true;

  void _onTap(String k, int num) {
    // Disable GestureDetector's 'onTap' property.
    setState(() => _enabled = false);
    checkanswer(k, num);
  }

//
  Widget choicebutton(String k, int num) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(400),
          ),
          child: GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                  color: btncolor[k],
                  borderRadius: BorderRadius.circular(400),
                ),
                height: 55,
                //color: btncolor[k],
                child: ListTile(
                  leading: Visibility(
                    visible: btntrue[k],
                    child: CircleAvatar(
                      child: Text(
                        k,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  title: Text(questions[num]),
                  trailing: Visibility(
                    visible: !btntrue[k],
                    child: CircleAvatar(
                      child: icon,
                      backgroundColor: Colors.white,
                    ),
                  ),
                )),
            onTap: () => _enabled ? _onTap(k, num) : null,
            //onTap: () => checkanswer(k, num),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            size: 28,
          ),
        ),
        title: Center(child: Text("Test", textAlign: TextAlign.center)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () async {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuestionFinishPage(tureQuiz, wrongQuiz)),
                  );
                },
                icon: Text("quiz.final".tr())),
          )
        ],
      ),
      backgroundColor: Color(0xff242a40),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.bottomLeft,
            child: Text(
              "quiz.word".tr() + " : ${question[id].kelime}",
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          choicebutton("A", 0),
          SizedBox(
            height: 10,
          ),
          choicebutton("B", 1),
          SizedBox(
            height: 10,
          ),
          choicebutton("C", 2),
          SizedBox(
            height: 10,
          ),
          choicebutton("D", 3),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 60,
              alignment: Alignment.center,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdHelper.createBannerAd()..load(),
              ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
            onPressed: () {
              setState(() {
                if (id == question.length - 1) {
                  _showInterstitialAd();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuestionFinishPage(tureQuiz, wrongQuiz)),
                  );
                } else {
                  id++;
                  questions.clear();
                  genrandomarray(id);
                  _enabled = true;
                  btntrue = {
                    "A": true,
                    "B": true,
                    "C": true,
                    "D": true,
                  };
                  btncolor = {
                    "A": Colors.black12,
                    "B": Colors.black12,
                    "C": Colors.black12,
                    "D": Colors.black12,
                  };
                }
              });
            },
            child: Text(
                id != question.length - 1
                    ? "quiz.skip".tr()
                    : "quiz.final".tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }

  genrandomarray(int _id) {
    var distinctIds = [];
    List _questions = [];
    int sayi;
    var rand = new Random();
    random_array = distinctIds.toSet().toList();
    random_array.add(_id);
    for (var i = 0;;) {
      sayi = rand.nextInt(question.length);
      if (random_array.length < 4) {
        if (random_array.contains(sayi)) {
          continue;
        } else {
          random_array.add(sayi);
          continue;
        }
      } else {
        break;
      }
    }
    for (var i = 0; i < random_array.length; i++) {
      _questions.add(question[random_array[i]].karsilik);
    }
    // for (int i = 0;;) {
    //   distinctIds.add(rand.nextInt(question.length));
    //   random_array = distinctIds.toSet().toList();
    //   if (random_array.length < 3) {
    //     int random = _id;
    //     while (_id == random) {
    //       random = rand.nextInt(question.length);
    //     }
    //     continue;
    //   } else {
    //     break;
    //   }
    // }
    // for (var i = 0; i < random_array.length; i++) {
    //   _questions.add(question[random_array[i]].karsilik);
    // }
    _questions.shuffle();
    setState(() {
      questions = _questions;
    });
    print(_questions);
    print(random_array);
  }

  Body() {
    for (var i = 0; i < data.length; i++) {
      if (data[i].isActive == 1) {
        question.add(data[i]);
      }
    }
  }

  void cevaplar(int _id) {
    //   random(min, max) {
    //     var rn = new Random();
    //     return min + rn.nextInt(max - min);
    //   }

    //   List _questions = [];
    //   List number = [];
    //   _questions.add(data[_id].karsilik);
    //   var randomizer = new Random();
    //   var l = List.generate(3, (_) {
    //     int random = _id;
    //     while (random == _id) {
    //       random = randomizer.nextInt(question.length);
    //     }
    //     return random;
    //   });
    //   for (var i = 0; i < l.length; i++) {
    //     _questions.add(question[l[i]].karsilik);
    //   }
    //   _questions.shuffle();

    //   setState(() {
    //     questions = _questions;
    //   });
    // }
  }
}
