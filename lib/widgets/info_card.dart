import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String svgIcon;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Aumentado el padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              height: isDesktop ? 120 : 80, // Aumentado el tamaño del icono
              width: isDesktop ? 120 : 80,
            ),
            const Gap(24), // Aumentado el espacio
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:
                    isDesktop ? 24 : 20, // Aumentado el tamaño de la fuente
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: Colors.grey[600],
                height: 1.5, // Agregado interlineado
              ),
            ),
          ],
        ),
      ),
    );
  }
}
