import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/notification_controller.dart';
import 'providers/poll_provider.dart';
import 'screens/auth/auth_gate.dart';
import 'screens/chat/chat_with_other_screen.dart';
import 'screens/chat/single_chat/chat_screen.dart';
import 'screens/firebase/firebase_screen.dart';
import 'screens/home/main_screen.dart';
import 'screens/polls/poll_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
    RemoteNotification? notification = remoteMessage.notification;

    print("first part");
    if (notification == null) return;

    print("second part");
    // RemoteNotification? notification = message.notification;

    createNotification(
      (notification.title as String),
      (notification.body as String),
    );

    print('onMessage');

    // print(event);
  });
  await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.green,
          ledColor: Colors.green,
        )
      ],
      debug: true);
  AwesomeNotifications().setChannel(
    NotificationChannel(
        channelKey: "secondary",
        channelName: "secondary",
        channelDescription: "channelDescription"),
  );
  // AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     null,
  //     [
  //       NotificationChannel(
  //           playSound: true,
  //           enableVibration: true,
  //           enableLights: true,
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'alerts',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //           channelGroupKey: 'basic_channel_group',
  //           channelGroupName: 'Basic group')
  //     ],
  //     debug: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PollProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              return AuthGate();
            }

            return Container();
          },
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => FirebaseScreen());

            case '/notification-page':
              return MaterialPageRoute(builder: (context) {
                final ReceivedAction receivedAction =
                    settings.arguments as ReceivedAction;
                return MainScreen();
              });

            default:
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },
        routes: {
          ChatScreen.url: (context) => const ChatScreen(),
          ChatWithOtherScreen.url: (context) => const ChatWithOtherScreen(),
          // GetPollsScreen.url: (context) => const GetPollsScreen(),
          PollScreen.url: (context) => const PollScreen(),
        },
      ),
    );
  }
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
  RemoteNotification? notification = message.notification;

  if (notification != null) {
    await createNotification(
      (notification.title as String),
      (notification.body as String),
    );
  }
}

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
    // actionButtons: [
    //   NotificationActionButton(key: 'REDIRECT', label: 'ilet'),
    //   NotificationActionButton(
    //       key: 'REPLY',
    //       label: 'Cevapla',
    //       requireInputText: true,
    //       actionType: ActionType.SilentAction),
    //   NotificationActionButton(
    //       key: 'DISMISS',
    //       label: 'Gizle',
    //       actionType: ActionType.DismissAction,
    //       isDangerousOption: true)
    // ],
  );
}
// Future<void> _firebasePushHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   AwesomeNotifications().createNotificationFromJsonData(message.data);
// }
