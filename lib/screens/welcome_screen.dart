import 'package:flutter/material.dart';
import 'package:safereturn/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:safereturn/widgets/widgets.dart';
import 'package:safereturn/screens/screens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final width = deviceSize.width;
    final isDesktop = width >= 1200;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Header fijo
            Container(
              height: deviceSize.height * 0.15,
              width: deviceSize.width,
              color: colors.primary,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayWhiteText(
                    text: 'SafeReturn',
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(8),
                  DisplayWhiteText(
                    text: 'Plataforma de objetos perdidos',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            Positioned(
              top: deviceSize.height * 0.15,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? deviceSize.width * 0.3 : 24,
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Gap(64),
                        Text(
                          '¿Cómo funciona?',
                          style: TextStyle(
                            fontSize: isDesktop ? 24 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(16),
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDesktop ? 3 : 1,
                            childAspectRatio: isDesktop
                                ? 0.65
                                : 0.80, // Ajustado para mejor visualización en tablets
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                          ),
                          children: const [
                            InfoCard(
                              title: 'Reporta',
                              description: 'Reporta tus objetos perdidos',
                              svgIcon: 'assets/icons/report.svg',
                            ),
                            InfoCard(
                              title: 'Registra',
                              description: 'Registra tus objetos perdidos',
                              svgIcon: 'assets/icons/community.svg',
                            ),
                            InfoCard(
                              title: 'Recupera',
                              description: 'Recupera tus objetos perdidos',
                              svgIcon: 'assets/icons/recover.svg',
                            ),
                          ],
                        ),
                        const Gap(24),
                      ],
                    ),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(64.0),
                        child: Column(
                          children: [
                            Text(
                              '¿Has perdido algo?',
                              style: TextStyle(
                                fontSize: isDesktop ? 24 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'Ayuda a otros a encontrar sus objetos perdidos',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isDesktop ? 16 : 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Gap(24),
                            FilledButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(200, 45),
                              ),
                              child: const Text('Iniciar Sesión'),
                            ),
                            const Gap(12),
                            OutlinedButton(
                              onPressed: () {
                                // TODO: Implementar navegación a registro
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(200, 45),
                              ),
                              child: const Text('Registrarse'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(24),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
