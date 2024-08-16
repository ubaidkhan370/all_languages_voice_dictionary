import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../database/db_helper.dart';
import '../../services/notification.dart';


class SettingScreenController extends GetxController {
  var notificationSwitchValue = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotificationSetting();
  }

  void _loadNotificationSetting() async {
    /// Get the value from SQLite
    bool value = await DbHelper.dbInstance.getNotificationSetting();
    notificationSwitchValue.value = value;
  }

  void onChangeNotificationSwitch(bool value) {
    notificationSwitchValue.value = value;
    DbHelper.dbInstance.insertOrUpdateNotificationSetting(value);

    final localNotifications = FlutterLocalNotificationsPlugin();
    if (value) {
     // localNotifications.cancelAll();
      showLocalNotificationPeriodically();
    } else {
      localNotifications.cancelAll();
    }
  }
}
