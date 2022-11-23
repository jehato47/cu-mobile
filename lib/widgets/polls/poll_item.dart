import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';

import '../../providers/poll_provider.dart';

class PollItem extends StatefulWidget {
  final dynamic poll;
  const PollItem({Key? key, required this.poll}) : super(key: key);
  // const PollItem({super.key});

  @override
  State<PollItem> createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  @override
  Widget build(BuildContext context) {
    PollProvider pollProvider =
        Provider.of<PollProvider>(context, listen: false);

    final Map<String, dynamic> poll = widget.poll;

    final int days = DateTime(
      poll['end_date'].toDate().year,
      poll['end_date'].toDate().month,
      poll['end_date'].toDate().day,
    )
        .difference(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ))
        .inDays;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          // margin: const EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterPolls(
              userVotedOptionId: pollProvider.checkOption(poll['id']),
              hasVoted: pollProvider.checkIfVoted(poll['id']),

              pollId: poll['id'].toString(),
              // hasVoted: hasVoted.value,
              // userVotedOptionId: userVotedOptionId.value,

              onVoted: (PollOption pollOption, int newTotalVotes) async {
                // print(pollOption.id);
                await pollProvider.addVote(
                  poll["id"],
                  FirebaseAuth.instance.currentUser!.uid,
                  pollOption.id,
                );

                // await Future.delayed(const Duration(seconds: 1));

                /// If HTTP status is success, return true else false
                return true;
              },
              pollEnded: days < 0,
              pollTitle: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  poll['question'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              leadingVotedProgessColor: Theme.of(context).primaryColor,
              votedProgressColor:
                  Theme.of(context).primaryColor.withOpacity(0.4),

              pollOptions: List<PollOption>.from(
                poll['options'].map(
                  (option) {
                    var a = PollOption(
                      id: option['id'],
                      title: Text(
                        option['text'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // votes: option['votes'],
                      votes: pollProvider.calculateVotes(
                        poll["id"],
                        option["id"],
                      ),
                    );
                    return a;
                  },
                ),
              ),
              votedPercentageTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              metaWidget: Row(
                children: [
                  const SizedBox(width: 6),
                  const Text(
                    '•',
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    days < 0 ? "ended" : "ends $days days",
                  ),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              await pollProvider.removeVote(poll["id"], "jehat");
            },
            child: Text("Remove Vote")),
        Divider(thickness: 1),
      ],
    );
  }
}
