import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangPage extends StatefulWidget {
  LangPage({Key? key}) : super(key: key);

  @override
  _LangPageState createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
  @override
  void initState() {
    super.initState();
    _veriGuncelle();
  }

  Color colors = Color(0XFF373852);
  String _value = "tr";
  Object val = -1;
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);
    return Scaffold(
      backgroundColor: Color(0XFF373852),
      appBar: AppBar(
        backgroundColor: Color(0XFF373852),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          "Dil (Language)",
          textAlign: TextAlign.center,
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text("langPage.title".tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
          ),
          ListBody(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _value = "tr";
                  });
                  context.locale = Locale("tr", "TR");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: ListTile(
                            leading: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Flag_of_the_Ottoman_Empire_%281844%E2%80%931922%29.svg/200px-Flag_of_the_Ottoman_Empire_%281844%E2%80%931922%29.svg.png',
                              width: 50,
                            ),
                            title: Text("Türkçe",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Visibility(
                                visible: _value == "tr" ? true : false,
                                child: Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _value = "en";
                  });
                  context.locale = Locale("en", "US");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: ListTile(
                            leading: Image.network(
                              'https://www.bayraklar.info/data/flags/ultra/gb.png',
                              width: 50,
                            ),
                            title: Text("English",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Visibility(
                                visible: _value == "en" ? true : false,
                                child: Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _value = "de";
                  });
                  context.locale = Locale("de", "DE");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: ListTile(
                            leading: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/200px-Flag_of_Germany.svg.png',
                              width: 50,
                            ),
                            title: Text("Deutsch",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Visibility(
                                visible: _value == "de" ? true : false,
                                child: Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _value = "fr";
                  });
                  context.locale = Locale("fr", "FR");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: ListTile(
                            leading: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/200px-Flag_of_France.svg.png',
                              width: 50,
                            ),
                            title: Text("Français",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Visibility(
                                visible: _value == "fr" ? true : false,
                                child: Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _value = "hi";
                  });
                  context.locale = Locale("hi", "IN");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: ListTile(
                            leading: Image.network(
                              'https://i.pinimg.com/originals/a7/16/5b/a7165b8b5c8dceca0582eb2217055644.gif',
                              width: 50,
                            ),
                            title: Text("हिंदी",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Visibility(
                                visible: _value == "hi" ? true : false,
                                child: Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _value = "ar";
                  });
                  context.locale = Locale("ar", "AR");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        child: ListTile(
                            leading: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/800px-Flag_of_Saudi_Arabia.svg.png',
                              width: 50,
                            ),
                            title: Text("شبه الجزيرة العربية",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700)),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Visibility(
                                visible: _value == "ar" ? true : false,
                                child: Icon(
                                  Icons.check_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Text("langPage.skip".tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _veriGuncelle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("key", 1);
  }
}
