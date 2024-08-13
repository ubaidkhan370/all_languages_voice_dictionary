import 'dart:io';
import 'dart:ui';

import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/history_screen/historyscreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translation.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/widgets/bottom_navigation_bar.dart';
import 'package:all_languages_voice_dictionary/widgets/dialog_box.dart';
import 'package:all_languages_voice_dictionary/widgets/drawer_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../global/global_variables.dart';
import '../../model/history_model.dart';
import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/reusable_stack.dart';
import '../../widgets/speaker_animation.dart';
import '../favourite_screen/favourite_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeScreenController homeScreenController = Get.put(
    HomeScreenController(),
  );
  FavouriteController favouriteController = Get.put(FavouriteController());
  final ScrollController scrollController = ScrollController();


  HistoryScreenController historyScreenController =
   Get.put(HistoryScreenController());
  DropDownButtonController dropDownButtonController =
      Get.put(DropDownButtonController());

  HistoryModel? historyModel;

  BannerAd? bannerAd;
  bool _isLoaded = false;
  RxInt currentIndex = 0.obs;

  List<String> suggestions = [
    'apple',
    'banana',
    'cherry',
    'date',
    'elderberry',
    'fig',
    'grape',
    'honeydew',
    'orange'
        'queen',
    'kingdom',
    'viking',
  ];

  RxInt _page = 0.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await customDialogBox(
            title: 'Exit App',
            voidCallBack: () {
              exit(0);
            },
            voidCallBack2: Get.back,
            content: 'Are you sure to exit from App?',
            context: context);
        return result;
      },
      child: SafeArea(
          child: Scaffold(
        bottomNavigationBar: bottomNavigationBar(currentIndex),
        backgroundColor: Colors.grey.shade200,
        //resizeToAvoidBottomInset: false,
        drawer: Drawer(
            width: Get.width * 0.8,
            child: ListView(
              children: [
                Container(
                  color: Color(0xFFE64D3D),
                  height: Get.height * 0.295,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 15),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.translate,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, left: 15),
                        child: Text(
                          'All Languages Voice Dictionary',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                drawerCard(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.home,
                    text: 'Home'),
                drawerCard(
                    onTap: () {
                      Get.to(TranslationScreen());
                    },
                    icon: Icons.translate,
                    text: 'Translation'),
                drawerCard(
                    onTap: () {
                      Get.to(HistoryScreen());
                    },
                    icon: Icons.history,
                    text: 'History'),
                drawerCard(
                    onTap: () {
                      Get.to(FavouriteScreen());
                    },
                    icon: Icons.favorite,
                    text: 'Favourites'),
                drawerCard(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.settings,
                    text: 'Setting'),
              ],
            )),
        appBar: AppBar(
          title: const Text(
            'ALL LANGUAGES DICTIONARY',
            style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFE64D3D),
        ),
        body: Column(
          children: [
            Obx(
                  () => (homeScreenController.adsHelper.isBannerAdLoaded.value &&
                  !GlobalVariable.isAppOpenAdShowing.value &&
                  !GlobalVariable.isInterstitialAdShowing.value)
                  ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3, vertical: 2),
                  child: SizedBox(
                    width: Get.width,
                    height: homeScreenController.adsHelper.bannerAd!.size.height
                        .toDouble(),
                    child:
                    AdWidget(ad: homeScreenController.adsHelper.bannerAd!),
                  ))
                  : (!GlobalVariable.isPurchasedMonthly.value &&
                  !GlobalVariable.isPurchasedYearly.value &&
                  !GlobalVariable.isPurchasedLifeTime.value)
                  ? SizedBox()
              //Expanded(
              // flex: 1,

              //
              // child: Shimmer.fromColors(
              //     baseColor: Colors.black,
              //     highlightColor: Colors.white,
              //     child: const NewsCardSkelton()),
              //    )
                  : const SizedBox(),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.28,
                    child: Stack(
                      children: [
                        Container(
                          height: Get.height * 0.28,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFE64D3D),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          //color: Colors.blue,
                        ),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: 12.0, top: Get.height * 0.03),
                        //   child: IconButton(
                        //     onPressed: () {
                        //
                        //     },
                        //     icon: Image.asset(
                        //       'assets/drawer.png',
                        //       // height: Get.height * 0.014.h,
                        //       // width: Get.width * 0.07.w,
                        //       height: Get.height * 0.016,
                        //       width: Get.width * 0.08,
                        //       //fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       vertical: Get.height * 0.09,
                        //       horizontal: Get.width * 0.2),
                        //   child: Text('ALL LANGUAGES DICTIONARY',
                        //       style: TextStyle(
                        //           fontFamily: 'Arial',
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w600,
                        //           color: Colors.white)),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 30.w,
                                  right: 30.w,
                                ),
                                margin: EdgeInsets.only(left: 10).r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Color(0xFFEFEFEF),
                                ),
                                child: customDropDownButton(
                                    homeScreenController.dropDownValue1,
                                    (String? newValue) {
                                  if (newValue != null) {
                                    homeScreenController.dropDownValue1.value =
                                        newValue;
                                    //dropDownButtonController.getLangCode(newValue);
                                    //String? languageCode = getLanguageCode(newValue);
                                    // if (languageCode != null) {
                                    //   homeScreenController.searchContain(
                                    //       homeScreenController.textEditingController
                                    //           .text, languageCode);
                                    // }
                                  }
                                }, Color(0xFFEFEFEF)),
                              ),
                              customIconButton(
                                () {
                                  String temp =
                                      homeScreenController.dropDownValue1.value;
                                  homeScreenController.dropDownValue1.value =
                                      homeScreenController.dropDownValue2.value;
                                  homeScreenController.dropDownValue2.value = temp;
                                },
                                'assets/swap_arrows.png',
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ).r,
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Color(0xFFEFEFEF),
                                ),
                                child: customDropDownButton(
                                  homeScreenController.dropDownValue2,
                                  (String? newValue) {
                                    if (newValue != null) {
                                      homeScreenController.dropDownValue2.value =
                                          newValue;
                                    }
                                  },
                                  Color(0xFFFFFFFF),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.13,
                              left: Get.width * 0.06,
                              right: Get.width * 0.06),
                          child: Container(
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 25.0).r,
                              child: Obx(() {
                                String currentText =
                                    homeScreenController.currentText.value;
                                bool isFavourite = favouriteController
                                    .favouritesList
                                    .contains(currentText);
                                bool isTextEmpty = currentText.isEmpty;

                                return Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text.isEmpty) {
                                      return const Iterable.empty();
                                    } else {
                                      return suggestions.where((String option) {
                                        return option.contains(
                                            textEditingValue.text.toLowerCase());
                                      });
                                    }
                                  },
                                  fieldViewBuilder: (
                                    BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted,
                                  ) {
                                    homeScreenController.textEditingController =
                                        textEditingController;
                                    homeScreenController.focusNode = focusNode;
                                    focusNode.addListener(() {
                                      homeScreenController
                                          .update(); // Trigger rebuild on focus change
                                    });
                                    return TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: focusNode.hasFocus
                                            ? ''
                                            : 'Write Something...',
                                        suffixIcon: Wrap(
                                          children: [
                                            // Padding(
                                            //   padding: EdgeInsets
                                            //       .only(bottom: 50)
                                            //       .r,
                                            //   child: Padding(
                                            //     padding: EdgeInsets
                                            //         .only(top: 8.0, right: 10)
                                            //         .r,
                                            //     child:
                                            //     ///favourite-button
                                            //     IconButton(
                                            //       onPressed: () {
                                            //         if (currentText.isNotEmpty) {
                                            //           if (isFavourite) {
                                            //             favouriteController
                                            //                 .deleteFromFavourite(
                                            //                 currentText
                                            //             );
                                            //           } else {
                                            //             favouriteController.addToFavourites(
                                            //                 currentText);
                                            //           }
                                            //         } else {
                                            //           return;
                                            //         }
                                            //       },
                                            //       icon: Icon(
                                            //         isFavourite ? Icons.favorite : Icons
                                            //             .favorite_border,
                                            //         color: isFavourite ? Colors.red : Color(
                                            //             0xFFE64D3D),
                                            //       ),
                                            //       color: isTextEmpty ? Colors.grey : null,
                                            //     ),
                                            //   ),
                                            // ),
                                            IconButton(
                                              onPressed: () {
                                                if (homeScreenController
                                                    .speechToText.isNotListening) {
                                                  homeScreenController
                                                      .startListening();
                                                  showListeningDialog(context);
                                                } else {
                                                  homeScreenController
                                                      .stopListening();
                                                }
                                              },
                                              tooltip: 'Listen',
                                              icon: Image.asset(
                                                'assets/speaker.png',
                                                height: Get.height * 0.035.h,
                                                width: Get.width * 0.04.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0, top: 4),
                                              child: IconButton(
                                                onPressed: () async {
                                                  await dropDownButtonController
                                                      .languageCode(
                                                          homeScreenController
                                                              .dropDownValue2
                                                              .value);
                                                  dropDownButtonController
                                                      .getLangCode(
                                                          homeScreenController
                                                              .dropDownValue2
                                                              .value);
                                                  historyScreenController
                                                      .addToHistory(
                                                          homeScreenController
                                                              .textEditingController
                                                              .text);
                                                  homeScreenController
                                                          .textEditingController
                                                          .text
                                                          .isNotEmpty
                                                      ? Get.to(() => Meaning())
                                                      : null;
                                                },
                                                icon: Image.asset(
                                                  'assets/search.png',
                                                  height: Get.height * 0.035.h,
                                                  width: Get.width * 0.07.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      controller:
                                          //homeScreenController.speechToText.isListening ? '${homeScreenController.lastWords}':
                                          //homeScreenController.textEditingController,
                                          textEditingController,
                                      focusNode: focusNode,
                                      onChanged: (text) {
                                        homeScreenController.updateTextField(text);
                                      },
                                      maxLines: 3,
                                    );
                                  },
                                  onSelected: (String selection) async {
                                    homeScreenController.updateTextField(selection);
                                    homeScreenController
                                        .textEditingController.text = selection;
                                    await dropDownButtonController.languageCode(
                                        homeScreenController.dropDownValue2.value);
                                    dropDownButtonController.getLangCode(
                                        homeScreenController.dropDownValue2.value);
                                    Get.find<HistoryScreenController>()
                                        .addToHistory(homeScreenController
                                            .textEditingController.text);
                                    Get.to(() => Meaning());
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Features',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE64D3D),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              if (scrollController.hasClients) {
                                scrollController.animateTo(
                                   scrollController.position.maxScrollExtent,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              }
                            },
                            child: Text('View all',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFE64D3D),
                                )))
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.17.h,
                    margin: EdgeInsets.only(left: 11, right: 11).r,
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      scrollDirection: Axis.horizontal,
                      children: [
                        reusableStack1(
                            image: 'assets/translations.png',
                            title: 'Translations',
                            onTap: () {
                              if (homeScreenController.adsHelper.interstitialAd !=
                                  null) {
                                homeScreenController.adsHelper.interstitialAd
                                    ?.show();
                                print('interstitial ad load successfuly');
                              } else {
                                print('interstitial ad not loaded');
                              }
                              Get.to(() => TranslationScreen());
                            }),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        reusableStack1(
                          image: 'assets/favourite.png',
                          title: 'Save Words',
                          onTap: () {
                            Get.to(() => FavouriteScreen());
                            if (homeScreenController.adsHelper.interstitialAd !=
                                null) {
                              homeScreenController.adsHelper.interstitialAd?.show();
                              print('interstitial ad load successfuly');
                            } else {
                              print('interstitial ad not loaded');
                            }
                          },
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        reusableStack1(
                            image: 'assets/history.png',
                            title: 'History',
                            onTap: () {
                              Get.to(() => HistoryScreen());
                            }),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        reusableStack1(
                          image: 'assets/share.png',
                          title: 'Share',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  // void showListeningDialog(BuildContext context) {
  void showListeningDialog(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0), // Adjust opacity as needed
            ),
          ),
          Center(
            child: SpeakerAnimation(),
          ),
        ],
      ),
    );

    overlayState?.insert(overlayEntry);

    // Remove the overlay entry after some time or based on some condition
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry?.remove();
    });
  }
}
