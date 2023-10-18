// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationController on NotificationControllerBase, Store {
  late final _$_setupTimezoneAsyncAction = AsyncAction(
      'NotificationControllerBase._setupTimezone',
      context: context);

  @override
  Future _setupTimezone() {
    return _$_setupTimezoneAsyncAction.run(() => super._setupTimezone());
  }

  late final _$_initializeNotificationsAsyncAction = AsyncAction(
      'NotificationControllerBase._initializeNotifications',
      context: context);

  @override
  Future _initializeNotifications() {
    return _$_initializeNotificationsAsyncAction
        .run(() => super._initializeNotifications());
  }

  late final _$checkForNotificationsAsyncAction = AsyncAction(
      'NotificationControllerBase.checkForNotifications',
      context: context);

  @override
  Future checkForNotifications() {
    return _$checkForNotificationsAsyncAction
        .run(() => super.checkForNotifications());
  }

  late final _$scheduleNotificationAsyncAction = AsyncAction(
      'NotificationControllerBase.scheduleNotification',
      context: context);

  @override
  Future<dynamic> scheduleNotification(
      {required NotificationModel notificationModel,
      required String scheduleNotificationDateTime,
      List<int>? days}) {
    return _$scheduleNotificationAsyncAction.run(() => super
        .scheduleNotification(
            notificationModel: notificationModel,
            scheduleNotificationDateTime: scheduleNotificationDateTime,
            days: days));
  }

  late final _$NotificationControllerBaseActionController =
      ActionController(name: 'NotificationControllerBase', context: context);

  @override
  dynamic _onNotification(NotificationResponse? response) {
    final _$actionInfo = _$NotificationControllerBaseActionController
        .startAction(name: 'NotificationControllerBase._onNotification');
    try {
      return super._onNotification(response);
    } finally {
      _$NotificationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showNotification(NotificationModel notificationModel) {
    final _$actionInfo = _$NotificationControllerBaseActionController
        .startAction(name: 'NotificationControllerBase.showNotification');
    try {
      return super.showNotification(notificationModel);
    } finally {
      _$NotificationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ({bool check, String date}) _checkDay(
      {required List<int> days, required String dateTime}) {
    final _$actionInfo = _$NotificationControllerBaseActionController
        .startAction(name: 'NotificationControllerBase._checkDay');
    try {
      return super._checkDay(days: days, dateTime: dateTime);
    } finally {
      _$NotificationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
