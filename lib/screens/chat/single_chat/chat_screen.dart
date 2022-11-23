import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/widgets/chat/single_chat/message_bubble.dart';
import 'package:cu_mobile/widgets/chat/single_chat/message_input.dart';
import 'package:cu_mobile/widgets/chat/single_chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const url = "chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final groupId = args["groupId"] as String;
    final subject = args["subject"] as String;

    ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Messages(
              scrollController: _scrollController,
              groupId: groupId,
            ),
          ),
          MessageInput(
            scrollController: _scrollController,
            groupId: groupId,
          )
        ],
      ),
    );
  }
}
