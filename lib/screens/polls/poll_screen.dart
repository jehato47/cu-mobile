import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/models/poll.dart';
import 'package:cu_mobile/providers/poll_provider.dart';
import 'package:cu_mobile/screens/polls/single_poll_stream.dart';
import 'package:cu_mobile/widgets/polls/poll_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollScreen extends StatefulWidget {
  static const url = "poll";
  const PollScreen({super.key});

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Poll Screen")),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("polls").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
          List<QueryDocumentSnapshot> docs = querySnapshot.docs;
          // print(docs);
          PollProvider pollProvider =
              Provider.of<PollProvider>(context, listen: false);
          List<Poll> polls = docs
              .map((e) => Poll(
                    id: e["id"],
                    question: e["question"],
                    options: e["options"],
                    endDate: e["end_date"].toDate(),
                    votes: e["votes"],
                    onCreated: e["onCreated"].toDate(),
                  ))
              .toList();
          // pollProvider.polls = polls;

          // print(polls);
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                // return PollItem(
                //   poll: polls[index],
                // );

                return SinglePollStream(
                  poll: polls[index],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
