import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cu_mobile/models/poll.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PollProvider extends ChangeNotifier {
  // List<Poll> polls = [];

  bool checkIfVoted(Poll poll) {
    bool voted = false;

    final votes = poll.votes;
    votes.forEach((vote) {
      if (vote["uid"] == "jehat") {
        voted = true;
      }
    });

    return voted;
  }

  int? checkOption(Poll poll) {
    if (!checkIfVoted(poll)) return null;
    int option = 0;

    final votes = poll.votes;
    votes.forEach((vote) {
      if (vote["uid"] == "jehat") {
        option = vote["option"];
      }
    });
    print(option);
    return option;
  }

  Future<void> addVote(Poll poll, String uid, int? option) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("polls")
        .where("id", isEqualTo: poll.id)
        .get();

    final docs = snapshot.docs;
    List votes = docs[0].data()["votes"];
    bool voted = checkIfVoted(poll);
    if (voted) {
      votes.removeWhere((element) => element["uid"] == "jehat");
    } else {
      votes.add({"uid": "jehat", "option": option});
    }

    await FirebaseFirestore.instance
        .collection("polls")
        .doc(docs[0].id)
        .update({
      "votes": votes,
    });
  }

  int calculateVotes(Poll poll, int optionId) {
    // final poll = polls.firstWhereOrNull((element) => element.id == pollId);
    int numberOfVotes = 0;
    final votes = poll.votes;
    votes.forEach((vote) {
      if (vote["option"] == optionId) {
        numberOfVotes++;
      }
    });

    return numberOfVotes;
  }

  Future<void> removeVote(Poll poll, String uid) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("polls")
        .where("id", isEqualTo: poll.id)
        .get();

    final docs = snapshot.docs;
    List votes = docs[0].data()["votes"];
    votes.removeWhere((element) => element["uid"] == "jehat");

    await FirebaseFirestore.instance
        .collection("polls")
        .doc(docs[0].id)
        .update({
      "votes": votes,
    });
  }
}
