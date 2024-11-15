import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safereturn/services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? additionalActions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.additionalActions,
  });

  void _logout(BuildContext context) async {
    await AuthService().logout();
    if (context.mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        ...?additionalActions,
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
