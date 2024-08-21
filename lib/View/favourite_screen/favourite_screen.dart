import 'package:all_languages_voice_dictionary/View/favourite_screen/favourite_controller.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translation.dart';
import 'package:all_languages_voice_dictionary/View/translation_screen/translationscreen_controller.dart';
import 'package:all_languages_voice_dictionary/controller/dropdownbutton_controller.dart';
import 'package:all_languages_voice_dictionary/View/meaning_screen/meaning.dart';
import 'package:all_languages_voice_dictionary/widgets/bottom_navigation_bar.dart';
import 'package:all_languages_voice_dictionary/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  //HomeScreenController homeScreenController = Get.put(HomeScreenController());
  FavouriteController favouriteController = Get.put(FavouriteController());
  TranslationScreenController translationScreenController =
      Get.put(TranslationScreenController());
  DropDownButtonController dropDownButtonController =
      Get.find<DropDownButtonController>();
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(currentIndex),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(HomeScreen());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFFE64D3D),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90.0).r,
                  child: const Text('Favourites',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color(0xFFE64D3D),
                          fontFamily: 'arial')),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Obx(() {
              if (Get.find<FavouriteController>().favouritesList.isEmpty) {
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: Get.height * 0.2),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/nodata.gif'),
                      Center(child: Text("No Favorites available",style: TextStyle(
                          fontFamily: 'Arial', color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w700
                      ),)),
                    ],
                  ),
                );
              }else
              return Expanded(
                child: ListView.builder(
                  itemCount: favouriteController.favouritesList.length,
                  itemBuilder: (context, index) {
                    final favoriteTable =
                        favouriteController.favouritesList[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<String> words =
                                favoriteTable.text.split(RegExp(r'\s+'));

                            if (words.length == 1) {
                              // await dropDownButtonController
                              //     .languageCode(
                              //     homeScreenController
                              //         .dropDownValue2
                              //         .value);
                              // dropDownButtonController
                              //     .getLangCode(
                              //     homeScreenController
                              //         .dropDownValue2
                              //         .value);
                              Get.find<HomeScreenController>().searchContain(
                                  favoriteTable.text,
                                  Get.find<HomeScreenController>().dropDownValue2.value);
                              Get.to(() => Meaning());
                            } else {
                              String translatedText =
                                  await translationScreenController
                                      .translateText(favoriteTable.text);
                              translationScreenController.translatedText.value =
                                  translatedText;
                              Get.to(TranslationScreen());
                            }
                          },
                          child: SizedBox(
                            height: Get.height * 0.1,
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFE64D3D),
                                  width: 0.5,
                                ),
                              ),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    //favouriteController.favouritesList[index],
                                    favoriteTable.text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontFamily: 'arial'),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        customDialogBox(title: 'delete'
                                            , content: 'Are you sure you want to delete?',
                                            context: context,
                                            voidCallBack: () async {
                                              if(favoriteTable.id != null){
                                                await favouriteController.deleteFromFavourite(favoriteTable.text);
                                                Get.back();
                                              }
                                            },
                                            voidCallBack2: (){
                                          Get.back();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xFFE64D3D),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
