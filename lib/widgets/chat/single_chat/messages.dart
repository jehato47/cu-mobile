import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Future.delayed(
  //     //   Duration.zero,
  //     //   () {
  //     //     final ScrollController _scrollController = widget.scrollController;

  //     //     if (_scrollController.hasClients) {
  //     //       _scrollController.animateTo(
  //     //         _scrollController.position.maxScrollExtent,
  //     //         duration: Duration(milliseconds: 300),
  //     //         curve: Curves.easeOut,
  //     //       );
  //     //       // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //     //     }
  //     //   },
  //     // );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = widget.scrollController;

    return StreamBuilder(
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

        Future.delayed(Duration.zero).then((value) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
            // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
        return ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            final doc = docs[index];
            return MessageBubble(
              doc["text"] ?? "",
              doc["displayName"] ?? "Anonymous",
              doc["uid"] == FirebaseAuth.instance.currentUser!.uid,
              doc["onCreated"].toDate(),
            );
          },
          itemCount: docs.length,
        );
      },
    );
  }
}
