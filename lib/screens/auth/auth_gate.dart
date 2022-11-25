import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../home/main_screen.dart';
import 'authentication_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData || FirebaseAuth.instance.currentUser != null) {
          return const MainScreen();
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
