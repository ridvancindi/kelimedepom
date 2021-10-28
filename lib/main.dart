import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelimedepom/langpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Notification.dart';
import 'homepage.dart';

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
        home:FirsScreen());
  }
}
class FirsScreen extends StatefulWidget {
  const FirsScreen({ Key? key }) : super(key: key);

  @override
  _FirsScreenState createState() => _FirsScreenState();
}

class _FirsScreenState extends State<FirsScreen> with AfterLayoutMixin<FirsScreen> {
  String? lang = "tr";
  Future checkFirstScreen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _screen = (prefs.getBool("slider") ?? false);
    if (_screen) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      await prefs.setBool("slider", true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LangPage(lang!)));
    }
  }
  @override
  void afterFirstLayout(BuildContext context) => checkFirstScreen();
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}