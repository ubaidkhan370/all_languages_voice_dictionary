import 'dart:async';

import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SplashController extends GetxController{
//
//
//   @override
//   void onReady(){
//     super.onReady();
//     checkNotificationSetting();
//   }
//   checkNotificationSetting() {
//     bool? res = GetStorage().read('notificationValue');
//     if (res == null) {
//       GetStorage().write('notificationValue', true);
//       showLocalNotificationPeriodically();
//     }
//   }
// }


import '../../database/db_helper.dart';
import '../../services/notification.dart'; // Update this import to your DbHelper class

class SplashController extends GetxController {
  //HomeScreenController homeScreenController = Get.put(HomeScreenController());
  AdsHelper adsHelper = AdsHelper();
  var loadingProgress = 0.obs;
  @override
  void onReady() {
    super.onReady();
    checkNotificationSetting();
    startLoading();
    _checkLanguageSelectionStatus();

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  void checkNotificationSetting() async {
    bool res = await DbHelper.dbInstance.getNotificationSetting();
    if (res == null) {
      /// If there is no value in the database, set it to true by default
      await DbHelper.dbInstance.insertOrUpdateNotificationSetting(true);
      showLocalNotificationPeriodically();
    } else if (res == true) {
      /// If the value is true, continue with periodic notifications
      showLocalNotificationPeriodically();
    }
    /// If the value is false, do nothing (notifications are disabled)
  }

  void _checkLanguageSelectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seenLanguageSelection =
        prefs.getBool('seenLanguageSelection') ?? false;
    bool? seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenLanguageSelection) {
      if (seenOnboarding) {
        Get.offNamed('/home');
        print(seenOnboarding);
      } else {
        Get.offNamed('/onBoardingScreen');
        print(seenOnboarding);
      }
    } else {
      Get.offNamed('/languageLocalizationScreen');
      print(seenOnboarding);
    }
  }

  void startLoading(){
    Timer.periodic(Duration(milliseconds:600 ),(timer){
      if(loadingProgress.value<100){
        loadingProgress.value+=10;

      }else{
        timer.cancel();
        print("Progress complete, showing ad...");
        adsHelper.showAppOpenAd();
      }
    });

  }
}
