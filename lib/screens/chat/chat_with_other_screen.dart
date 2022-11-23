import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/screens/chat/single_chat/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatWithOtherScreen extends StatefulWidget {
  static const url = "chat_with_other";
  const ChatWithOtherScreen({super.key});

  @override
  State<ChatWithOtherScreen> createState() => _ChatWithOtherScreenState();
}

class _ChatWithOtherScreenState extends State<ChatWithOtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
