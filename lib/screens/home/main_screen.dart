import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/screens/auth/authentication_screen.dart';
import 'package:cu_mobile/screens/chat/chat_with_other_screen.dart';
import 'package:cu_mobile/screens/chat/single_chat/chat_screen.dart';
import 'package:cu_mobile/screens/firebase/firebase_screen.dart';
import 'package:cu_mobile/screens/polls/get_polls_screen.dart';
import 'package:cu_mobile/widgets/polls/polls_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => AuthenticationScreen(),
              // ));
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
            ),
          ),
          IconButton(
            onPressed: () async {
              // await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed(GetPollsScreen.url);

              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => AuthenticationScreen(),
              // ));
            },
            icon: const FaIcon(
              FontAwesomeIcons.squarePollHorizontal,
            ),
          ),
        ],
        title: const Text('Flutter Polls 🗳'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () async {
            //     await FirebaseFirestore.instance.collection("messages").add({
            //       "text": "text",
            //       "onCreated": DateTime.now(),
            //       "uid": "id",
            //       "isMe": false,
            //       "displayName": FirebaseAuth.instance.currentUser!.displayName,
            //     });
            //   },
            //   child: Text("message"),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await FirebaseFirestore.instance.collection("groups").add({
            //       "subject": "text",
            //       "description": "description",
            //       "onCreated": DateTime.now(),
            //       "uid": "id",
            //       "isDisabled": false,
            //       "displayName": FirebaseAuth.instance.currentUser!.displayName,
            //     });
            //   },
            //   child: Text("group"),
            // ),
            Expanded(child: ChatWithOtherScreen()),
          ],
        ),
      ),
    );
  }
}
