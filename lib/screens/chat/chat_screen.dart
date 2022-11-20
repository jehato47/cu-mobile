import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/screens/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const url = "chat";
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("messages")
            .orderBy("onCreated")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final docs = (snapshot.data as QuerySnapshot).docs;

          return ListView.builder(
            itemBuilder: (context, index) {
              final doc = docs[index];
              return MessageBubble(
                doc["text"],
                "jehat deniz",
                doc["isMe"],
                DateTime.now(),
              );
            },
            itemCount: docs.length,
          );
        },
      ),
    );
  }
}
