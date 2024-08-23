import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FlagWidget extends StatelessWidget {
  final String countryCode;
  final double size;

  FlagWidget({required this.countryCode, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: Get.width*0.3,
      width: Get.width*0.3,
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(40),
         //border: Border.all(color: const Color(0xFF575DDC), width: 1),
        image: DecorationImage(
          fit:BoxFit.cover,
          image: AssetImage(
            'icons/flags/png/$countryCode.png',
            package:'country_icons',
          ),
        ),
      ),
    );
  }
}
