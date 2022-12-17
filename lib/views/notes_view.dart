import 'package:flutter/material.dart';
import 'package:todo/services/auth/auth_service.dart';

import '../constants/routes.dart';
import '../enums/menue_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          PopupMenuButton<MenueAction>(
            onSelected: (value) async {
              switch (value) {
                case MenueAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logout();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
                  break;
                case MenueAction.login:
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: MenueAction.logout, child: Text("Logout")),
                PopupMenuItem(value: MenueAction.login, child: Text("Login")),
              ];
            },
          )
        ],
      ),
      body: const Text("Hello world"),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign out"),
          content: const Text("sure to sign out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Log Out"),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
