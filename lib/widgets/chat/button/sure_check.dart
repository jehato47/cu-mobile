import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SureCheck extends StatefulWidget {
  final String groupId;
  const SureCheck({super.key, required this.groupId});

  @override
  State<SureCheck> createState() => _SureCheckState();
}

class _SureCheckState extends State<SureCheck> {
  @override
  Widget build(BuildContext context) {
    String groupId = widget.groupId;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Şikayetinizi silmek istediğinize emin misiniz?",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await FirebaseFirestore.instance
                      .collection("groups")
                      .doc(groupId)
                      .update({
                    "isDisabled": true,
                  });
                },
                child: Text("Evet"),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Hayır"),
              ),
            )
          ]),
        ],
      ),
    );
    ;
  }
}
