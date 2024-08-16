import 'package:all_languages_voice_dictionary/View/setting_screen/settingscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  SettingScreenController settingScreenController =
      Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style:  TextStyle(
                fontFamily: 'Arial', color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFE64D3D),
          iconTheme: const IconThemeData(
            color: Colors.white, // Set the color of the back button here
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.notifications,color:  Colors.grey.shade700,),
                    Text(
                      '           Notifications',
                      style: TextStyle(
                          fontFamily: 'Arial', color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                trailing: Obx(
                  () => Switch(
                    activeColor:Color(0xFFE64D3D),
                    value:
                        settingScreenController.notificationSwitchValue.value,
                    onChanged:
                        settingScreenController.onChangeNotificationSwitch,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
