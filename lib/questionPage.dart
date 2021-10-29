import 'package:flutter/material.dart';

class questionPage extends StatefulWidget {
  questionPage({Key? key}) : super(key: key);

  @override
  _questionPageState createState() => _questionPageState();
}

class _questionPageState extends State<questionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("question"),),
    );
  }
}