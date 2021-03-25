import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample_app/second_screen.dart';
import 'package:sample_app/resource/global/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifyProvider = Provider((ref) => NotifyProvider(ref.read));
final notifyPermissionFutureProvider = StateProvider<bool>((_) => false);

final notificationAppLaunchDetailsProvider =
    FutureProvider<NotificationAppLaunchDetails>((ref) async {
  final flutterLocalNotificationsPlugin = ref.read(notificationProvider);
  final l =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  return l;
});

class NotifyProvider {
  NotifyProvider(this.read);
  final Reader read;

  Future<void> initState() async {
    await _configureLocalTimeZone();
    read(notifyPermissionFutureProvider).state =
        await _checkNotifyPermissions();
    return;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = tz.getLocation('America/Asuncion').toString();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<bool> _checkNotifyPermissions() {
    return Permission.notification.isGranted;
  }

  Future<void> showNotification(BuildContext context) async {
    final flutterLocalNotificationsPlugin = read(notificationProvider);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void dispose() {}

  Future<void> updateNotifyPermission() async {
    final notify = await _checkNotifyPermissions();
    read(notifyPermissionFutureProvider).state = notify;
    return;
  }
}

final notificationProvider = Provider<FlutterLocalNotificationsPlugin>((_) {
  Future onSelectNotification(String payload) async {
    final nav = _.read(navKeyProvider);
    nav.currentState.pushNamed(SecondScreen.routeName);
  }

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  // ignore: prefer_function_declarations_over_variables
  final initialize = () async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      await onSelectNotification(payload);
    });
  };
  initialize();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  return flutterLocalNotificationsPlugin;
});
