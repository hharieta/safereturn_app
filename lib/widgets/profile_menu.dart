import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safereturn/services/auth_service.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  void _logout(BuildContext context) async {
    await AuthService().logout();
    if (context.mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.account_circle),
      onSelected: (value) {
        if (value == 'logout') {
          _logout(context);
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'profile',
          child: Text('Mi Perfil'),
        ),
        const PopupMenuItem<String>(
          value: 'settings',
          child: Text('Configuración'),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Cerrar Sesión'),
        ),
      ],
    );
  }
}
