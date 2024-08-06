import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/screens/widgets/my_text_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUpUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 27),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            MyTextField(
              controller: passwordController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: signUpUser,
                child: const Text(
                  'Sing In',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
