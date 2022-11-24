import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../screens/chat/single_chat/chat_screen.dart';

class NewGroupButton extends StatefulWidget {
  const NewGroupButton({super.key});

  @override
  State<NewGroupButton> createState() => NewGroupButtonState();
}

class NewGroupButtonState extends State<NewGroupButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final _controller = TextEditingController();

        // Navigator.pushNamed(context, ChatScreen.url);
        await showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Şikayetinizi ne konuda oluşturmak istediğinizi aşağıda belirtiniz.",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                    Divider(),
                    TextFormField(
                      controller: _controller,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_controller.text.length < 5) return;

                        DocumentReference ref = await FirebaseFirestore.instance
                            .collection("groups")
                            .add({
                          // "name": "name",
                          "isDisabled": false,
                          "subject": _controller.text,
                          "onCreated": DateTime.now(),
                          "uid": "id",
                          "isMe": false,
                          "displayName":
                              FirebaseAuth.instance.currentUser!.displayName,
                        });
                        // Navigator.of(context).pop();
                        DocumentSnapshot item = await ref.get();
                        print(item["subject"]);
                        // await Future.delayed(Duration(seconds: 1));
                        _controller.clear();
                        Navigator.pushReplacementNamed(context, ChatScreen.url,
                            arguments: {
                              "groupId": item.id,
                              "subject": item["subject"],
                            });
                      },
                      child: Text("Send"),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const FaIcon(FontAwesomeIcons.comment),
    );
  }
}
