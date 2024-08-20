import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/dropdown_button.dart';
import '../../widgets/iconbutton.dart';
import '../../widgets/textbutton.dart';
import '../home_screen/home_screen.dart';

class Splash4 extends StatelessWidget {
   Splash4({super.key});
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top:Get.width* 0.14,left: Get.width * 0.6 ),
            child: TextButton(onPressed: (){Get.to(()=>HomeScreen());}, child: Text('Skip',style: TextStyle(color: Colors.grey),)),
          ),
          SizedBox(height: Get.height* 0.14,),
          Text(
            'Set Your Primary Language',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w800,
                color: Color(0xFFE64D3D)),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Get.height * 0.02,
              bottom: Get.height * 0.03,
            ),
            child: Text(
                'Our Translation feature makes it simple to understand and language.\n'
                    '        Just enter your text and get a clear translation in seconds',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.w700,
                    color: Colors.grey)),
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                height: Get.height * 0.28,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFFE64D3D),
                  borderRadius: BorderRadius.circular(15)
                ),
                //color: Colors.blue,
              ),

              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30
                      ),
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFEFEFEF),
                      ),
                      child: customDropDownButton(
                          homeScreenController.dropDownValue1,
                              (String? newValue) {
                            if (newValue != null) {
                              homeScreenController.dropDownValue1.value =
                                  newValue;
                            }
                          }, Color(0xFFEFEFEF),Color(0xFFE64D3D)),
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
                      ),
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                          Color(0xFFFFFFFF),Color(0xFFE64D3D)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 60,),
          customTextButton(
            voidCallBack: () {
              Get.to(()=>HomeScreen());
            },
            title: 'Next',
            color: Color(0xFFE64D3D),

          ),
        ],
      ),
    );
  }
}
