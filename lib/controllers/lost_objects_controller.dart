import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safereturn/models/models.dart';
import 'package:safereturn/services/lost_objects_service.dart';

class LostObjectsController extends ChangeNotifier {
  final _lostObjectsService = LostObjectsService();
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _searchQuery = '';
  List<Objects> _objects = [];
  bool _isLoading = false;

  TextEditingController get searchController => _searchController;
  String get searchQuery => _searchQuery;
  List<Objects> get objects => _objects;
  bool get isLoading => _isLoading;

  LostObjectsController() {
    _loadObjects();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchQuery = query;
      _loadObjects();
    });
  }

  Future<void> _loadObjects() async {
    try {
      _isLoading = true;
      notifyListeners();

      _objects =
          await _lostObjectsService.getLostObjects(searchQuery: _searchQuery);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Manejar el error según tu lógica
    }
  }
}
