import 'dart:math';

import 'package:flutter/material.dart';

import 'db/dbHelper.dart';
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
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Body();
  }

  @override
  Widget build(BuildContext context) {
    cevaplar(5);
    return Scaffold(
      appBar: AppBar(
        title: Text("question"),
      ),
    );
  }

  Body() {
    for (var i = 0; i < data.length; i++) {
      if (data[i].isActive == 1) {
        question.add(data[i]);
      }
    }
  }

  void cevaplar(int id) {
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    List questions = [];
    List number = [];
    questions.add(data[id].karsilik);
    var randomizer = new Random();
    var l = List.generate(3, (_) => randomizer.nextInt(question.length));
    print(l);
    for (var i = 0; i < l.length; i++) {
      questions.add(question[i].karsilik);
    }
    print(questions);
  }
}
