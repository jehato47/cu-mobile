import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/widgets/polls/poll_item.dart';
import 'package:flutter/material.dart';

import '../../models/poll.dart';

class SinglePollStream extends StatefulWidget {
  final Poll poll;
  const SinglePollStream({super.key, required this.poll});

  @override
  State<SinglePollStream> createState() => _SinglePollStreamState();
}

class _SinglePollStreamState extends State<SinglePollStream> {
  @override
  Widget build(BuildContext context) {
    Poll poll = widget.poll;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("polls")
            .where("id", isEqualTo: poll.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            // print(snapshot.data);
            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            QueryDocumentSnapshot doc = querySnapshot.docs[0];
            Poll db_poll = Poll(
              id: doc["id"],
              question: doc["question"],
              options: doc["options"],
              endDate: doc["end_date"].toDate(),
              votes: doc["votes"],
              onCreated: doc["onCreated"].toDate(),
            );
            return PollItem(
              poll: db_poll,
            );
          }
          return Container();
        });
  }
}
