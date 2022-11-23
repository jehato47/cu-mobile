import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        providers: [
          EmailAuthProvider(),
        ],
        // actions: [
        //   AuthStateChangeAction<SignedIn>((context, state) {
        //     Navigator.pushReplacement(context, MaterialPageRoute(
        //       builder: (context) {
        //         return MainScreen();
        //       },
        //     ));
        //   }),
        // ],
        // providerConfigs: [
        //   EmailProviderConfiguration(),
        //   // if (kIsWeb)

        //   GoogleProviderConfiguration(
        //     clientId:
        //         '735404252029-h0p1hja97mb7gndh4egdr1octue33k8c.apps.googleusercontent.com',
        //   ),
        // ],
      ),
    );
  }
}
