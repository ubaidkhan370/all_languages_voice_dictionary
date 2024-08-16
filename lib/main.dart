import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_screen.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash3.dart';
import 'package:all_languages_voice_dictionary/View/splash_screen/splash_screen.dart';
import 'package:all_languages_voice_dictionary/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'View/home_screen/home_screen.dart';
import 'View/splash_screen/splash2.dart';
import 'View/translation_screen/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LocalNotification.init();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await MobileAds.instance.initialize();
  final translator = GoogleTranslator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown
  ]);

  LocalNotification service = LocalNotification();
  service.initializeLocalNotifications();

  // var delegate = await LocalizationDelegate.create(
  //   fallbackLocale: 'en_US', // Fallback locale if translation is not available
  //   supportedLocales: ['en_US', 'es_ES'], // Add more locales as needed
  //   // preferences: TranslatePreferences(),
  //   // baseUrl: 'https://your-translation-service.com/',  // URL to Google Translate or custom service
  //   // //apiKey: 'YOUR_GOOGLE_TRANSLATE_API_KEY',  // API key for Google Translate (optional)
  // );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //var localizationDelegate = LocalizedApp.of(context).delegate;
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        // translations: AppTranslations(),
        // locale: Locale('en'), // default locale
        // fallbackLocale: Locale('en'),
        title: 'Flutter Demo',
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
          // TranslateLocalizationDelegate.delegate, // Add TranslateLocalizationDelegate
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
        initialRoute: '/',
        getPages:[
          GetPage(name: '/',page: ()=>SplashScreen()),
          GetPage(name: '/splash2',page: ()=>Splash2()),
          GetPage(name: '/splash3',page: ()=>Splash3()),
          GetPage(name: '/home',page: ()=>HomeScreen()),
          GetPage(name: '/translation',page: ()=>TranslationScreen()),
          GetPage(name: '/favourite',page: ()=>FavouriteScreen()),
          GetPage(name: '/history',page: ()=>HistoryScreen()),
          GetPage(name: '/meaning',page: ()=>Meaning()),
          GetPage(name: '/history',page: ()=>HistoryScreen()),
        ],
        debugShowCheckedModeBanner: false,
      ),
      designSize: Size(384, 854),
    );
  }
}
//////////third comit

///
// class AppTranslations extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//     'en': {
//       'title': 'Hello',
//     },
//     'fr': {
//       'title': 'Bonjour',
//     },
//     'de': {
//       'title': 'Hallo',
//     },
//     'es': {
//       'title': 'Hola',
//     },
//   };
// }
