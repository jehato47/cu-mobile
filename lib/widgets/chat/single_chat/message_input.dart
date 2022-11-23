import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageInput extends StatefulWidget {
  // final dynamic doc;
  final ScrollController scrollController;
  final String groupId;
  const MessageInput({
    super.key,
    required this.scrollController,
    required this.groupId,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();
  FocusNode node = FocusNode();

  Future<void> _send() async {
    ScrollController _scrollController = widget.scrollController;
    // dynamic doc = widget.doc;

    if (_controller.text.trim().isEmpty) return;
    String text = _controller.text;
    _controller.clear();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    // _scrollController.jumpTo(
    //   _scrollController.position.maxScrollExtent,
    // );

    print("sent");

    await FirebaseFirestore.instance.collection("messages").add({
      "type": "message",
      "uid": auth.currentUser!.uid,
      "text": text,
      "displayName": auth.currentUser!.displayName,
      "onCreated": DateTime.now(),
      "groupId": widget.groupId,
    });
    // await FirebaseFirestore.instance.collection("messages").add({
    //   "text": "text",
    //   "onCreated": DateTime.now(),
    //   "uid": "id",
    //   "isMe": false,
    // });
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      // TODO: Burada row'u niye kullandığına bak
      child: Row(
        children: [
          // TODO : Var olan alanı tamamen kapladığı için textfield'ı expanded
          // içine koyduk
          Expanded(
            child: TextField(
              focusNode: node,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              onSubmitted: (value) async {
                await _send();
                node.requestFocus();
              },
              textInputAction: TextInputAction.send,
              controller: _controller,
              onChanged: (value) {
                // setState(() {
                //   _enteredMessage = value;
                // });
              },
              decoration: InputDecoration(
                labelText: "Mesajınızı Yazın",
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _send,
          )
        ],
      ),
    );
  }
}
