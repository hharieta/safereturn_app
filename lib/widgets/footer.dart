import 'package:flutter/material.dart';
import 'package:safereturn/utils/utils.dart';
import 'package:gap/gap.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 768 && width < 1024;
    return Container(
      width: double.infinity,
      color: colors.primary.withOpacity(0.1),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop
            ? 64
            : isTablet
                ? 32
                : 24,
        vertical: 24,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SafeReturn',
                    style: TextStyle(
                      fontSize: isDesktop ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Plataforma de objetos perdidos',
                    style: TextStyle(
                      fontSize: isDesktop ? 16 : 14,
                      color: colors.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.facebook, color: colors.primary),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.email, color: colors.primary),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.help_outline, color: colors.primary),
                  ),
                ],
              ),
            ],
          ),
          const Gap(24),
          const Divider(),
          const Gap(16),
          Text(
            '© ${DateTime.now().year} SafeReturn. Todos los derechos reservados.',
            style: TextStyle(
              fontSize: isDesktop ? 14 : 12,
              color: colors.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
