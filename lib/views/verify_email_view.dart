import 'package:flutter/material.dart';
import 'package:todo/constants/routes.dart';
import 'package:todo/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("verify Email")),
      body: Column(
        children: [
          const Text(
              "We've sent you email verification please click on the link to verify the email"),
          const Text(
              "If you have'nt received a email please press the below button"),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text("Verify")),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
