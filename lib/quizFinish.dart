import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admobHelper.dart';

class quizFinish extends StatefulWidget {
  var falseQuestion = <Map<String, dynamic>>[];
  int trueNum;
  int falseNum;

  quizFinish(this.falseQuestion, this.trueNum, this.falseNum);

  @override
  _quizFinishState createState() => _quizFinishState();
}

class _quizFinishState extends State<quizFinish> {
  List selectedUsers = [];
  late BannerAd _bannerAd;
  bool _isBanneradReady = false;
  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icon(Icons.chevron_left_rounded)),
        title: Text("Quiz Sonucu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Doğru Sayın",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.trueNum.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Yanlış Sayın",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.falseNum.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isBanneradReady == true)
                 Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                ),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  "Yanlış Bildiğin Kelimeler",
                  style: TextStyle(fontSize: 15),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 450,
                  child: ListView.builder(
                      itemCount: widget.falseQuestion.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                      widget.falseQuestion[index]["kelime"],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                      widget.falseQuestion[index]["hata"],
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  trailing: Text(
                                      widget.falseQuestion[index]["karsilik"],
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
