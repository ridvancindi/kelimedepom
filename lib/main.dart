import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kelimedepom/addData.dart';
import 'package:kelimedepom/langpage.dart';
import 'package:kelimedepom/questionPage.dart';
import 'package:kelimedepom/quiz.dart';
import 'package:kelimedepom/testpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Notification.dart';
import 'db/dbHelper.dart';
import 'homepage.dart';
import 'models/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  MobileAds.instance.initialize();
  localNotifyManager.showNightNotification();
  localNotifyManager.showDayTimeNotification();

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('tr', 'TR'),
          Locale('de', 'DE'),
          Locale('hi', 'IN'),
          Locale('fr', 'FR'),
          Locale('az', 'AZ'),
          Locale('el', 'EL'),
          Locale('es', 'ES'),
          Locale('it', 'IT'),
          Locale('ja', 'JA'),
          Locale('ko', 'KO'),
          Locale('ru', 'RU'),
          Locale('ar', 'AR')
        ],
        path: 'assets/langs',
        fallbackLocale: Locale('tr', 'TR'),
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: FirsScreen());
  }
}

class FirsScreen extends StatefulWidget {
  const FirsScreen({Key? key}) : super(key: key);

  @override
  _FirsScreenState createState() => _FirsScreenState();
}

class _FirsScreenState extends State<FirsScreen>
    with AfterLayoutMixin<FirsScreen> {
  String? lang = "tr";
  Future checkFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _screen = (prefs.getBool("slider") ?? false);
    if (_screen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePages()));
    } else {
      await prefs.setBool("slider", true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LangPage(lang!)));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstScreen();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int currentIndex = 0;
  final pages = [HomePage(), TestPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              color: currentIndex == 0 ? Colors.deepOrange : Colors.black  ,
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            ),
            SizedBox(width: 48.0),
            IconButton(
              iconSize: 25,
              color: currentIndex == 1 ? Colors.deepOrange : Colors.black  ,
              icon: Icon(
                Icons.library_books,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          bool result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => addData()));
        },
      ),
    );
  }

  void selectPage(index) {
    setState(() {
      currentIndex = index;
    });
  }
}
