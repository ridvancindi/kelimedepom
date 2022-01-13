import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:kelimedepom/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class LangPage extends StatefulWidget {
  String lang;
  LangPage(this.lang);
  @override
  _LangPageState createState() => _LangPageState(lang);
}

class _LangPageState extends State<LangPage> {
  String? lang;
  _LangPageState(this.lang);
  @override
  void initState() {
    super.initState();
    _veriGuncelle();
  }

  Color colors = Color(0XFF373852);
  Object val = -1;
  List<Map<String, String>> allLang = [
    {
      "id": "l1",
      "title": "Türkçe",
      "lang": "tr",
      "elang": "TR",
      "img": "assets/flag/tr.png"
    },
    {
      "id": "l1",
      "title": "Azerice",
      "lang": "az",
      "elang": "AZ",
      "img": "assets/flag/az.png"
    },
    {
      "id": "l1",
      "title": "English",
      "lang": "en",
      "elang": "US",
      "img": "assets/flag/en.png"
    },
    {
      "id": "l1",
      "title": "Deutsch",
      "lang": "de",
      "elang": "DE",
      "img": "assets/flag/de.png"
    },
    {
      "id": "l1",
      "title": "Français",
      "lang": "fr",
      "elang": "FR",
      "img": "assets/flag/fr.png"
    },
    {
      "id": "l1",
      "title": "हिंदी",
      "lang": "hi",
      "elang": "IN",
      "img": "assets/flag/hi.png"
    },
    {
      "id": "l1",
      "title": "شبه الجزيرة العربية",
      "lang": "ar",
      "elang": "AR",
      "img": "assets/flag/ar.png"
    },
    {
      "id": "l1",
      "title": "Ελληνικά",
      "lang": "el",
      "elang": "EL",
      "img": "assets/flag/el.png"
    },
    {
      "id": "l1",
      "title": "Español",
      "lang": "es",
      "elang": "ES",
      "img": "assets/flag/es.png"
    },
    {
      "id": "l1",
      "title": "Italiano",
      "lang": "it",
      "elang": "IT",
      "img": "assets/flag/it.png"
    },
    {
      "id": "l1",
      "title": "日本",
      "lang": "ja",
      "elang": "JA",
      "img": "assets/flag/ja.png"
    },
    {
      "id": "l1",
      "title": "한국인",
      "lang": "ko",
      "elang": "KO",
      "img": "assets/flag/ko.png"
    },
    {
      "id": "l1",
      "title": "Pусский",
      "lang": "ru",
      "elang": "RU",
      "img": "assets/flag/ru.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    String _value = lang!;
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
      body: Container(
        child: ListView.builder(
          itemCount: allLang.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("lang", allLang[index]["lang"]!);
                _langData();
                setState(() {
                  _value = allLang[index]["lang"]!;
                });
                context.locale =
                    Locale(allLang[index]["lang"]!, allLang[index]["elang"]!);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 65,
                      child: ListTile(
                          leading: Image(
                            image: AssetImage(allLang[index]["img"]!),
                            width: 50,
                          ),
                          title: Text(allLang[index]["title"]!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700)),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Visibility(
                              visible: _value == allLang[index]["lang"]!
                                  ? true
                                  : false,
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
            );
          },
        ),
        // Container(
        //   child: Expanded(
        //     child: Align(
        //       alignment: FractionalOffset.bottomCenter,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: SizedBox(
        //           height: 55,
        //           width: double.infinity,
        //           child: ElevatedButton(
        //             style:
        //                 ElevatedButton.styleFrom(primary: Colors.orange),
        //             onPressed: () {
        //               if (Navigator.canPop(context)) {
        //                 Navigator.pop(context);
        //               } else {
        //                 Navigator.of(context).pushReplacement(
        //                     MaterialPageRoute(
        //                         builder: (context) => HomePage()));
        //               }
        //             },
        //             child: Text("langPage.skip".tr(),
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 17,
        //                     fontWeight: FontWeight.w700)),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.orange),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePages()));
              }
            },
            child: Text("langPage.skip".tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }

  void _veriGuncelle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("key", 1);
  }

  void _langData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    lang = pref.getString("lang");
  }
}
//Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/800px-Flag_of_Saudi_Arabia.svg.png',width: 50,),