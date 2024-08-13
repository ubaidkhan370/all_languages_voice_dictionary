import 'package:all_languages_voice_dictionary/View/history_screen/history_screen.dart';
import 'package:all_languages_voice_dictionary/View/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget bottomNavigationBar(RxInt currentIndex){
  return Theme(
    data: ThemeData(
        canvasColor: Colors.grey.shade200
    ),
    child: SizedBox(
      height: Get.height * 0.09,
      child: BottomNavigationBar(
          onTap: (index){
            currentIndex.value = index;
            if(currentIndex.value==0){
              Get.to(HomeScreen());
            }else if(currentIndex.value==1){Get.to(HistoryScreen());}else if(currentIndex.value ==2){
              Get.to(HomeScreen());
            }
          },
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                  height: Get.height * 0.03,
                  child: Image.asset('assets/home.png',),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: SizedBox(
                  height: Get.height * 0.03,
                  child: Image.asset('assets/history.png'),),
              label: 'History',  // Provide a non-empty label for better accessibility
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                  height: Get.height * 0.03,
                  child:Image.asset('assets/setting.png'),),
              label: 'Setting',  // Provide a non-empty label for better accessibility
            ),
          ],
      ),
    ),
  );
}



