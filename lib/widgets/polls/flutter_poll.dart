import 'package:cu_mobile/models/poll.dart';
import 'package:cu_mobile/providers/poll_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';

class FlutterPoll extends StatefulWidget {
  final int days;
  final Poll poll;
  const FlutterPoll({super.key, required this.poll, required this.days});

  @override
  State<FlutterPoll> createState() => _FlutterPollState();
}

class _FlutterPollState extends State<FlutterPoll> {
  @override
  Widget build(BuildContext context) {
    PollProvider pollProvider =
        Provider.of<PollProvider>(context, listen: false);
    Poll poll = widget.poll;
    int days = widget.days;

    return FlutterPolls(
      userVotedOptionId: pollProvider.checkOption(poll),
      hasVoted: pollProvider.checkIfVoted(poll),

      pollId: poll.id.toString(),
      // hasVoted: hasVoted.value,
      // userVotedOptionId: userVotedOptionId.value,

      onVoted: (PollOption pollOption, int newTotalVotes) async {
        // print(pollOption.id);
        await pollProvider.addVote(
          poll,
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
          poll.question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      leadingVotedProgessColor: Theme.of(context).primaryColor,
      votedProgressColor: Theme.of(context).primaryColor.withOpacity(0.4),

      pollOptions: List<PollOption>.from(
        poll.options.map(
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
                poll,
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
    );
  }
}
