import 'package:flutter/material.dart';
import 'package:safereturn/widgets/lost_object_card.dart';
import 'package:safereturn/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:safereturn/controllers/controllers.dart';

class LostObjectsScreen extends StatelessWidget {
  const LostObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LostObjectsController(),
      child: const _LostObjectsView(),
    );
  }
}

class _LostObjectsView extends StatelessWidget {
  const _LostObjectsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LostObjectsController>();
    final colors = context.colorScheme;
    final size = context.deviceSize;
    final isDesktop = size.width >= 1024;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Objetos Perdidos'),
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? size.width * 0.1 : 16, vertical: 16),
              child: Center(
                child: SizedBox(
                  width: isDesktop ? size.width * 0.3 : double.infinity,
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar objetos...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: controller.onSearchChanged,
                  ),
                ),
              ),
            ),
            Expanded(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : controller.objects.isEmpty
                      ? const Center(child: Text('No hay objetos perdidos'))
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? size.width * 0.1 : 16,
                            vertical: 16,
                          ),
                          child: LostObjectCard(objects: controller.objects),
                        ),
            )
          ],
        ));
  }
}
