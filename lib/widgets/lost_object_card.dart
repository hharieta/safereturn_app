import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:safereturn/models/models.dart';
import 'package:safereturn/utils/utils.dart';

class LostObjectCard extends StatelessWidget {
  final List<Objects> objects;

  const LostObjectCard({
    super.key,
    required this.objects,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final colors = context.colorScheme;
    final isDesktop = deviceSize.width >= 1024;

    return SizedBox(
      width: isDesktop ? deviceSize.width * 0.5 : double.infinity,
      height: deviceSize.height * 0.8,
      child: ListView.separated(
        itemCount: objects.length,
        itemBuilder: (BuildContext context, int index) {
          final object = objects[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () =>
                  context.go('/dashboard/lost-objects/${object.idobject}'),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        Uint8List.fromList(object.images[0].getImageBytes()!),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            object.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            object.description ?? 'Sin descripción',
                            style: TextStyle(
                              color: colors.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: colors.primary,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Gap(8),
      ),
    );
  }
}
