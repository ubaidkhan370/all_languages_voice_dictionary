import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  LanguageSelectionScreenState createState() => LanguageSelectionScreenState();
}

class LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Afrikaans', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Arabic', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Chines', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Czech', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Danish', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Dutch', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'French', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'German', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Greek', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Hindi', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Indonesian', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Italian', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Japanese', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Korean', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Malay', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Norwegian', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Persion', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Portuguese', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Russian', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Spanish', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Thai', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Turkish', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Urdu', 'flag': 'assets/icons/gps_logo.png'},
    {'name': 'Vietnamese', 'flag': 'assets/icons/gps_logo.png'},
  ];

  String? _selectedLanguage;

  void _selectLanguage(String language) async {
    setState(() {
      _selectedLanguage = language;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    await prefs.setBool('seenLanguageSelection', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Select Language'),
        actions: [
          ElevatedButton(
              onPressed: _selectedLanguage != null
                  ? () {
                Get.offNamed('/onBoardingScreen');
              }
                  : null,
              child: Text("Next")),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2 / 2, // Increase width and decrease height
        ),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedLanguage == languages[index]['name'];
          return GestureDetector(
            onTap: () => _selectLanguage(languages[index]['name']!),
            child: Card(
              color: isSelected ? Colors.blue.shade100 : Colors.white,
              shape: isSelected
                  ? RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(8),
              )
                  : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(languages[index]['flag']!, width: 80, height: 80),
                  SizedBox(height: 6),
                  Text(
                    languages[index]['name']!,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
