import 'package:flutter/material.dart';
import 'package:safereturn/utils/utils.dart';
import 'package:safereturn/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final width = deviceSize.width;

    // Definir breakpoints para diferentes dispositivos
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'SafeReturn',
        additionalActions: [
          ProfileMenu(),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top:
                isDesktop ? deviceSize.height * 0.25 : deviceSize.height * 0.15,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? deviceSize.width * 0.15 : 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isDesktop || isTablet)
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: isDesktop
                                ? (deviceSize.width * 0.7 / 3) - 16
                                : (deviceSize.width * 0.5) - 24,
                            height: deviceSize.height * 0.15,
                            child: ActionCard(
                              title: 'Ingresar objeto perdido',
                              description:
                                  'Aquí puedes reportar un objeto perdido',
                              icon: Icons.report_problem_outlined,
                              color: Colors.orange,
                              onTap: () => context.go('/dashboard/report'),
                            ),
                          ),
                          SizedBox(
                            width: isDesktop
                                ? (deviceSize.width * 0.7 / 3) - 16
                                : (deviceSize.width * 0.5) - 24,
                            height: deviceSize.height * 0.15,
                            child: ActionCard(
                              title: 'Buscar objeto perdido',
                              description:
                                  'Aquí puedes buscar un objeto perdido',
                              icon: Icons.search,
                              color: Colors.green,
                              onTap: () =>
                                  context.go('/dashboard/lost-objects'),
                            ),
                          ),
                          SizedBox(
                            width: isDesktop
                                ? (deviceSize.width * 0.7 / 3) - 16
                                : (deviceSize.width * 0.5) - 24,
                            height: deviceSize.height * 0.15,
                            child: ActionCard(
                              title: 'Objetos encontrados',
                              description:
                                  'Aquí puedes ver los objetos encontrados',
                              icon: Icons.list_alt,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          SizedBox(
                            height: 80,
                            child: ActionCard(
                              title: 'Reportar objeto perdido',
                              description: '¿Perdiste algo? Repórtalo aquí',
                              icon: Icons.report_problem_outlined,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 80,
                            child: ActionCard(
                              title: 'He encontrado algo',
                              description:
                                  '¿Encontraste un objeto? Ayuda a devolverlo',
                              icon: Icons.search,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 80,
                            child: ActionCard(
                              title: 'Objetos encontrados',
                              description:
                                  'Lista de objetos que extrañan a sus dueños',
                              icon: Icons.list_alt,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Text(
                      'Últimos objetos reportados',
                      style: TextStyle(
                        fontSize: isDesktop ? 24 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RecentItemsList(isDesktop: isDesktop),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
