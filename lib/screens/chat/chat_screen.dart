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
    ScrollController _scrollController = ScrollController();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Messages(scrollController: _scrollController),
          ),
          MessageInput(_scrollController)
        ],
      ),
    );
  }
}
