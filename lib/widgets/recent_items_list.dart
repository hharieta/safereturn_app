import 'package:flutter/material.dart';

class RecentItemsList extends StatelessWidget {
  final bool isDesktop;

  const RecentItemsList({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        childAspectRatio: isDesktop ? 2.5 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.image, color: Colors.grey, size: 20),
            ),
            title: Text(
              'Objeto perdido #${index + 1}',
              style: const TextStyle(fontSize: 14),
            ),
            subtitle: const Text(
              'Ubicación: Ciudad Universitaria',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              'Hace ${index + 1}h',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
