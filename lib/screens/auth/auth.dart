import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/screens/home.dart';
import 'package:my_notes/screens/sign_in.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            //user is logged in
            if (snapShot.hasData) {
              return Home();
            }

            //user is not logged in
            else {
              return SignIn();
            }
          }),
    );
  }
}
