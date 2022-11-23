import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({super.key});

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("click"),
          onPressed: () async {
            await FirebaseFirestore.instance.collection("polls").add(
              {
                "onCreated": DateTime.now(),
                "id": 1,
                'votes': [
                  // {"uid": "jehat", "option": 1},
                  // {"uid": "deniz", "option": 1}
                ],
                "question": "What is your favorite color?",
                "options": [
                  {"id": 1, "text": "Red", "votes": 1},
                  {"id": 2, "text": "Green", "votes": 1},
                  {"id": 3, "text": "Blue", "votes": 1},
                ],
                "end_date": DateTime.now().add(Duration(days: 7)),
              },
            );
            // return;
            await FirebaseFirestore.instance.collection("polls").add(
              {
                "onCreated": DateTime.now(),
                'id': 2,
                'votes': [
                  // {"uid": "jehat", "option": 1},
                  // {"uid": "deniz", "option": 1}
                ],
                'question': 'Do you think Oranguntans have the ability speak?',
                'end_date': DateTime(2022, 12, 25),
                'options': [
                  {'id': 1, 'text': 'Yes, they definitely do', 'votes': 40},
                  {'id': 2, 'text': 'No, they do not', 'votes': 0},
                  {'id': 3, 'text': 'I do not know', 'votes': 10},
                  {'id': 4, 'text': 'Why should I care?', 'votes': 30}
                ],
              },
            );
            return;
            await FirebaseAuth.instance.currentUser!
                .updateDisplayName("jehat deniz");
            // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
            //   if (!isAllowed) {
            //     // This is just a basic example. For real apps, you must show some
            //     // friendly dialog box before call the request method.
            //     // This is very important to not harm the user experience
            //     AwesomeNotifications().requestPermissionToSendNotifications();
            //   }
            // });

            final token = await FirebaseMessaging.instance.getToken();
            print(token);
            FirebaseFirestore.instance
                .collection('users')
                .doc('token')
                .set({'token': token});

            // AndroidForegroundService.startAndroidForegroundService(
            //     foregroundStartMode: ForegroundStartMode.stick,
            //     foregroundServiceType: ForegroundServiceType.phoneCall,
            //     content: NotificationContent(
            //         id: 2341234,
            //         body: 'Service is running!',
            //         title: 'Android Foreground Service',
            //         channelKey: 'basic_channel',
            //         bigPicture: 'asset://assets/images/android-bg-worker.jpg',
            //         notificationLayout: NotificationLayout.BigPicture,
            //         category: NotificationCategory.Service),
            //     actionButtons: [
            //       NotificationActionButton(
            //           key: 'SHOW_SERVICE_DETAILS', label: 'Show details')
            //     ]);

            // return;
            // await AwesomeNotifications().createNotification(
            //     content: NotificationContent(
            //         id: -1, // -1 is replaced by a random number
            //         channelKey: 'alerts',
            //         title: 'Huston! The eagle has landed!',
            //         body:
            //             "A small step for a man, but a giant leap to Flutter's community!",
            //         bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            //         largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //         notificationLayout: NotificationLayout.BigPicture,
            //         payload: {'notificationId': '1234567890'}),
            //     actionButtons: [
            //       NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
            //       NotificationActionButton(
            //           key: 'REPLY',
            //           label: 'Reply Message',
            //           requireInputText: true,
            //           actionType: ActionType.SilentAction),
            //       NotificationActionButton(
            //           key: 'DISMISS',
            //           label: 'Dismiss',
            //           actionType: ActionType.DismissAction,
            //           isDangerousOption: true)
            //     ]);
            return;

            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'Simple Notification',
                body: 'Simple body',
                actionType: ActionType.Default,
              ),
            );
            return;
            await FirebaseFirestore.instance.collection("polls").add(
              {
                "id": 1,
                'votes': [
                  // {"uid": "jehat", "option": 1},
                  // {"uid": "deniz", "option": 1}
                ],
                "question": "What is your favorite color?",
                "options": [
                  {"id": 1, "text": "Red", "votes": 1},
                  {"id": 2, "text": "Green", "votes": 1},
                  {"id": 3, "text": "Blue", "votes": 1},
                ],
                "end_date": DateTime.now().add(Duration(days: 7)),
              },
            );
            // return;
            await FirebaseFirestore.instance.collection("polls").add(
              {
                'id': 2,
                'votes': [
                  // {"uid": "jehat", "option": 1},
                  // {"uid": "deniz", "option": 1}
                ],
                'question': 'Do you think Oranguntans have the ability speak?',
                'end_date': DateTime(2022, 12, 25),
                'options': [
                  {'id': 1, 'text': 'Yes, they definitely do', 'votes': 40},
                  {'id': 2, 'text': 'No, they do not', 'votes': 0},
                  {'id': 3, 'text': 'I do not know', 'votes': 10},
                  {'id': 4, 'text': 'Why should I care?', 'votes': 30}
                ],
              },
            );
          },
        ),
      ),
    );
  }
}
