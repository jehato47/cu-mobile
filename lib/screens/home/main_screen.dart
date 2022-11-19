import 'package:cu_mobile/screens/firebase/firebase_screen.dart';
import 'package:cu_mobile/screens/polls/get_polls_screen.dart';
import 'package:cu_mobile/widgets/polls/polls_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Polls 🗳'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: GetPollsScreen(),
      ),
    );
  }
}
