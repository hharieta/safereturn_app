import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safereturn/services/auth_service.dart';
import 'package:safereturn/screens/screens.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    // Obtener el estado de autenticación
    final bool isLoggedIn = AuthService().isLoggedIn();
    //final _shellNavigatorKey = GlobalKey<NavigatorState>();

    // Ruta actual
    final String currentPath = state.matchedLocation;

    // Rutas públicas que no requieren autenticación
    const publicRoutes = ['/login', '/'];

    // Si el usuario no está autenticado y la ruta no es pública
    if (!isLoggedIn && !publicRoutes.contains(currentPath)) {
      return '/login';
    }

    // Si el usuario está autenticado y trata de acceder a login
    if (isLoggedIn && currentPath == '/login') {
      return '/home';
    }

    // En cualquier otro caso, permitir la navegación normal
    return null;
  },
  routes: [
    // Rutas públicas
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    // Rutas protegidas
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return AuthGuard(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'report',
              builder: (context, state) => const ReportFoundItemScreen(),
            ),
            GoRoute(
              path: 'lost-objects',
              builder: (context, state) => const LostObjectsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Widget para verificar autenticación
class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
