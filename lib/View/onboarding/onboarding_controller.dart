import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class OnBoardingController extends GetxController{
  RxBool isLastPage = false.obs;


  AdsHelper adsHelper = AdsHelper();
  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();
    loadAds();
  }
  void loadAds(){
    adsHelper.loadNativeAd();
    adsHelper.loadInterstitialAd();
  }

  void loadSecondAd(){
    if(adsHelper.nativeAd2==null){
      adsHelper.loadNativeAd2();
    }


  }

  void loadThirdAd(){
    if(adsHelper.nativeAd3==null){
      adsHelper.loadNativeAd3();
    }
    print("Third Ad loaded");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('Controller onclosed Called');
  }

}
