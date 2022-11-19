import 'package:cu_mobile/widgets/polls/poll_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';

// import '../../polls.dart';
import '../../providers/poll_provider.dart';

class PollsList extends StatefulWidget {
  const PollsList({super.key});

  @override
  State<PollsList> createState() => _PollsListState();
}

class _PollsListState extends State<PollsList> {
  @override
  Widget build(BuildContext context) {
    PollProvider pollProvider =
        Provider.of<PollProvider>(context, listen: false);
    List polls = pollProvider.polls;

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: polls.length,
        itemBuilder: (BuildContext context, int index) {
          return PollItem(poll: polls[index]);
        },
      ),
    );
  }
}
