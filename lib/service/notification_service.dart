import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

import '../../../generated/l10n.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("defaultIcon");

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {

        }
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {

        });

    _configureLocalTimeZone();
  }

  tz.TZDateTime _getTzTime(int time) {
    tzData.initializeTimeZones();
    return tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, time);
  }


  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    BuildContext? context
  }) async {
    return _notificationsPlugin.show(
        id,
        title,
        body,
        await notificationDetails()
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    final file =
    File('${(await getTemporaryDirectory()).path}/${path.split("/").last}');
    debugPrint("haudau path = ${file.path}");
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  Future<bool> checkExits(String filePath) async {
    File file = File(filePath);
    bool fileExists = file.existsSync();
    return fileExists;
  }

  Future<void> showNotificationWithTime({int id = 0}) async {
    var title = "";
    var body = "";
    title = "LocalDataNotification.titlesEN[index]";
    body = "LocalDataNotification.contentsEn[index]";
    // var images = LocalDataNotification.images[index];
    // var byteData = await rootBundle.load("assets/image/img_banner_export.webp");
    // final attachmentPicturePath = await getImageFileFromAssets(images);

    // var exits = await checkExits(attachmentPicturePath.path);
    // late DarwinNotificationDetails darwinNotificationDetails;
    // if (exits) {
    //   darwinNotificationDetails =
    //       DarwinNotificationDetails(attachments: <DarwinNotificationAttachment>[
    //     DarwinNotificationAttachment(
    //       attachmentPicturePath.path,
    //       hideThumbnail: false,
    //     )
    //   ]);
    // } else {
    //   darwinNotificationDetails = const DarwinNotificationDetails();
    // }

    await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
          android: AndroidNotificationDetails('channel_id', 'channel_name'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max
        ),
        iOS: DarwinNotificationDetails()
    );
  }

  Future<void> requestIOSPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  cancelAll() async => await _notificationsPlugin.cancelAll();

  cancel(id) async => await _notificationsPlugin.cancel(id);

  Future<void> _configureLocalTimeZone() async {
    // tz.initializeTimeZones();
  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    debugPrint(
        "NOTIFICATION schedule time =  ${scheduleDate.hour}  |  ${scheduleDate.minute} | ${scheduleDate.day}"
    );
    return scheduleDate;
  }
}
