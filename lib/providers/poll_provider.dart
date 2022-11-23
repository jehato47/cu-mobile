import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PollProvider extends ChangeNotifier {
  List polls = [];

  Future<void> getPolls() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("polls").get();

    final docs = snapshot.docs;
    polls = docs.map((e) => e.data()).toList();
    return;
  }

  bool checkIfVoted(int pollId) {
    bool voted = false;

    final poll = polls.firstWhereOrNull((element) => element["id"] == pollId);

    if (poll != null) {
      final votes = poll["votes"];
      votes.forEach((vote) {
        if (vote["uid"] == "jehat") {
          voted = true;
        }
      });
    }

    return voted;
  }

  int? checkOption(int pollId) {
    if (!checkIfVoted(pollId)) return null;
    int option = 0;

    final poll = polls.firstWhereOrNull((element) => element["id"] == pollId);

    if (poll != null) {
      final votes = poll["votes"];
      votes.forEach((vote) {
        if (vote["uid"] == "jehat") {
          option = vote["option"];
        }
      });
    }

    return option;
  }

  Future<void> addVote(int pollId, String uid, int? option) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("polls")
        .where("id", isEqualTo: pollId)
        .get();

    final docs = snapshot.docs;
    List votes = docs[0].data()["votes"];
    bool voted = checkIfVoted(pollId);
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

  int calculateVotes(int pollId, int optionId) {
    final poll = polls.firstWhereOrNull((element) => element["id"] == pollId);
    int numberOfVotes = 0;
    if (poll != null) {
      final votes = poll["votes"];
      votes.forEach((vote) {
        if (vote["option"] == optionId) {
          numberOfVotes++;
        }
      });
    }

    return numberOfVotes;
  }

  Future<void> removeVote(int pollId, String uid) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("polls")
        .where("id", isEqualTo: pollId)
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
