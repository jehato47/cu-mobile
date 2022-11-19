import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  Future<void> createNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            // title: 'Huston! The eagle has landed!',
            // body:
            //     "A small step for a man, but a giant leap to Flutter's community!",
            title: title,
            body: body,
            bigPicture:
                'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
            key: 'REDIRECT',
            label: 'ilet',
          ),
          NotificationActionButton(
              key: 'REPLY',
              label: 'Cevapla',
              requireInputText: true,
              actionType: ActionType.SilentAction),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Gizle',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);
  }
}
