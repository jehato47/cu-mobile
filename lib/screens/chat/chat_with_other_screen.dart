import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../widgets/chat/button/new_group_button.dart';
import '../../widgets/chat/button/sure_check.dart';
import 'single_chat/chat_screen.dart';

class ChatWithOtherScreen extends StatefulWidget {
  static const url = "chat_with_other";
  const ChatWithOtherScreen({super.key});

  @override
  State<ChatWithOtherScreen> createState() => _ChatWithOtherScreenState();
}

class _ChatWithOtherScreenState extends State<ChatWithOtherScreen> {
  void initState() {
    super.initState();
    FirebaseMessaging.instance.subscribeToTopic("chat");
    print("done");
    // FirebaseMessaging.onBackgroundMessage((message) {})
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NewGroupButton(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("groups")
            .where("isDisabled", isEqualTo: false)
            .orderBy("onCreated", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
            // return Center(child: LinearProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }
          final docs = (snapshot.data as QuerySnapshot).docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return SureCheck(groupId: docs[index].id);
                    },
                  );
                },
                onTap: () {
                  Navigator.pushNamed(context, ChatScreen.url, arguments: {
                    "groupId": docs[index].id,
                    "subject": docs[index]["subject"],
                  });
                },
                title: Text(docs[index]["subject"]),
                subtitle: Text(docs[index]["onCreated"].toDate().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
