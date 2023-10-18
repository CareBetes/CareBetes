import 'dart:async';

import 'package:care_betes/app/modules/notification/models/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
part 'notification_controller.g.dart';

class NotificationController = NotificationControllerBase
    with _$NotificationController;

abstract class NotificationControllerBase with Store {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationControllerBase() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  @action
  _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  @action
  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onDidReceiveNotificationResponse: _onNotification,
    );
  }

  @action
  _onNotification(NotificationResponse? response) {
    if (response != null && response.payload!.isNotEmpty) {
      Modular.to.pushNamed(response.payload!);
    }
  }

  @action
  showNotification(NotificationModel notificationModel) {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_show',
      'Lembretes_show',
      channelDescription: 'Apenas para notificar',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notificationModel.id,
      notificationModel.title,
      notificationModel.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notificationModel.payload,
    );
  }

  @action
  checkForNotifications() async {
    final datails =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (datails != null && datails.didNotificationLaunchApp) {
      _onNotification(datails.notificationResponse);
    }
  }

  @action
  Future scheduleNotification({
    required NotificationModel notificationModel,
    required String scheduleNotificationDateTime,
    List<int>? days,
  }) async {
    bool next = true;
    if (days != null && days.isNotEmpty) {
      next = _checkDay(
        days: days,
        dateTime: scheduleNotificationDateTime,
      ).check;
      scheduleNotificationDateTime = _checkDay(
        days: days,
        dateTime: scheduleNotificationDateTime,
      ).date;
    }

    if (!next) {
      return;
    }

    return await localNotificationsPlugin.zonedSchedule(
      notificationModel.id,
      notificationModel.title,
      notificationModel.body,
      tz.TZDateTime.from(
        DateTime.parse(scheduleNotificationDateTime),
        tz.local,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'lembretes_medical_appointment',
          'Lembretes_medical_appointment',
          channelDescription: 'Apenas para consultas',
          importance: Importance.max,
          priority: Priority.max,
          groupAlertBehavior: GroupAlertBehavior.all,
          enableVibration: true,
          autoCancel: false,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @action
  ({String date, bool check}) _checkDay({
    required List<int> days,
    required String dateTime,
  }) {
    final dateNow = DateTime.now();
    if (days.contains(dateNow.weekday)) {
      var date = DateTime.parse(
          '${dateNow.year}-${dateNow.month}-${dateNow.day} $dateTime');
      return (date: date.toString(), check: true);
    }
    return (date: dateNow.toString(), check: false);
  }
}
