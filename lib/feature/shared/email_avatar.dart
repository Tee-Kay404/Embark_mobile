import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAvatar extends StatelessWidget {
  const EmailAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Theme(
      data: ThemeData(
        splashFactory: NoSplash.splashFactory,
      ),
      child: GestureDetector(
        onTapDown: (TapDownDetails details) async {
          showMenu(
            color: Theme.of(context).colorScheme.primary,
            context: context,
            position: RelativeRect.fromLTRB(
              details.globalPosition.dx,
              details.globalPosition.dy,
              details.globalPosition.dx,
              details.globalPosition.dy,
            ),
            items: [
              PopupMenuItem(
                enabled: false,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    user?.email ?? 'No Email',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ),
            ],
          );

          await Future.delayed(Duration(seconds: 1));
          Navigator.pop(context); // closes the menu
        },
        child: CircleAvatar(
          maxRadius: 17.0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Text(
            user?.email?.characters.first.toUpperCase() ?? '?',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
