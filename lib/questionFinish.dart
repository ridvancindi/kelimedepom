import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestionFinishPage extends StatelessWidget {
  int trueQuiz;
  int wrongQuiz;
  QuestionFinishPage(this.trueQuiz, this.wrongQuiz);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: () async {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: Icon(Icons.close)),
            )
          ],
        ),
        backgroundColor: Color(0xff242a40),
        body: Center(
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 35, left: 35),
              child: Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                    color: Color(0xffccdde7),
                    borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(30.0),
                        bottomRight: const Radius.circular(30.0),
                        topLeft: const Radius.circular(30.0),
                        topRight: const Radius.circular(30.0))),
                constraints: BoxConstraints(maxHeight: 450.0, minHeight: 150.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                        height: 170,
                        image: AssetImage('assets/icon/winner.png')),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "TEBRİKLER !",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sınav Başarıyla Tamamlandı.",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          "Çözülen Soru Sayısı",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${trueQuiz + wrongQuiz}",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Doğru Sayısı",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "$trueQuiz",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Yanlış Sayısı",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "$wrongQuiz",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
