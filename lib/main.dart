import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
        home:HomePage());
  }
}
