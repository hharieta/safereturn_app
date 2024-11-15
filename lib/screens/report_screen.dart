import 'package:flutter/material.dart';
import 'package:safereturn/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';

class ReportFoundItemScreen extends StatefulWidget {
  const ReportFoundItemScreen({super.key});

  @override
  State<ReportFoundItemScreen> createState() => _ReportFoundItemScreenState();
}

class _ReportFoundItemScreenState extends State<ReportFoundItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _objectNameController = TextEditingController();
  final _finderNameController = TextEditingController();
  final _locationNameController = TextEditingController();
  final _locationAddressController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _foundDate;
  String? _selectedCategory;
  File? _imageFile;

  final List<String> _categories = [
    'Electrónicos',
    'Documentos',
    'Ropa',
    'Accesorios',
    'Otros'
  ];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _foundDate) {
      setState(() {
        _foundDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // TODO: Implementar la lógica para guardar en la base de datos
        // 1. Crear el objeto
        // final object = {
        //   'name': _objectNameController.text,
        //   'category': _selectedCategory,
        //   'description': _descriptionController.text,
        // };

        // 2. Guardar la ubicación
        // final location = {
        //   'name': _locationNameController.text,
        //   'address': _locationAddressController.text,
        // };

        // 3. Registrar el hallazgo
        // final found = {
        //   'findername': _finderNameController.text,
        //   'founddate': _foundDate,
        // };

        // 4. Guardar la imagen si existe
        // if (_imageFile != null) {
        //   final bytes = await _imageFile!.readAsBytes();
        //   // Guardar en la tabla images
        // }

        // 5. Crear el registro de estado inicial
        // status_history -> "Encontrado" o similar

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Objeto registrado correctamente')),
        );

        // Regresar a la pantalla anterior o ir al listado
        if (context.mounted) {
          context.go('/home');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar el objeto: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final width = deviceSize.width;
    final isDesktop = width >= 1200;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Objeto Encontrado'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? deviceSize.width * 0.3 : 24,
          vertical: 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección de imagen
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 48,
                              color: colors.primary,
                            ),
                            const Gap(8),
                            Text(
                              'Agregar foto del objeto',
                              style: TextStyle(color: colors.primary),
                            ),
                          ],
                        ),
                ),
              ),
              const Gap(24),

              // Información del objeto
              Text(
                'Información del Objeto',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(16),
              TextFormField(
                controller: _objectNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del objeto',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del objeto';
                  }
                  return null;
                },
              ),
              const Gap(16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione una categoría';
                  }
                  return null;
                },
              ),
              const Gap(16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              const Gap(24),

              // Información de la ubicación
              Text(
                'Ubicación',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(16),
              TextFormField(
                controller: _locationNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del lugar',
                  prefixIcon: Icon(Icons.place_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del lugar';
                  }
                  return null;
                },
              ),
              const Gap(16),
              TextFormField(
                controller: _locationAddressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección específica',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la dirección';
                  }
                  return null;
                },
              ),
              const Gap(24),

              // Información del hallazgo
              Text(
                'Información del Hallazgo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(16),
              TextFormField(
                controller: _finderNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de quien lo encontró',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const Gap(16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha del hallazgo',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _foundDate != null
                        ? '${_foundDate!.day}/${_foundDate!.month}/${_foundDate!.year}'
                        : 'Seleccionar fecha',
                  ),
                ),
              ),
              const Gap(32),

              // Botón de envío
              FilledButton(
                onPressed: _submitForm,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Registrar Objeto Encontrado',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _objectNameController.dispose();
    _finderNameController.dispose();
    _locationNameController.dispose();
    _locationAddressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
