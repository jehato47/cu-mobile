import 'package:cu_mobile/providers/poll_provider.dart';
import 'package:cu_mobile/widgets/polls/polls_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPollsScreen extends StatefulWidget {
  static const url = "get-polls";
  const GetPollsScreen({super.key});

  @override
  State<GetPollsScreen> createState() => _GetPollsScreenState();
}

class _GetPollsScreenState extends State<GetPollsScreen> {
  @override
  Widget build(BuildContext context) {
    PollProvider pollProvider = Provider.of<PollProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polls"),
      ),
      body: FutureBuilder(
        future: pollProvider.getPolls(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("Error"),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const PollsList();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
