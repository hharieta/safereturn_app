import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safereturn/models/models.dart';
import 'package:safereturn/services/storage_service.dart';

class LostObjectsService {
  static const String _baseUrl = 'http://localhost:3000';

  Future<List<Objects>> getLostObjects({String? searchQuery = ''}) async {
    try {
      final token = await StorageService().getToken();

      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final uri = Uri.parse(_baseUrl).replace(
          path: '/objects', queryParameters: {'searchString': searchQuery});

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodeData = json.decode(response.body);

        return decodeData
            .map<Objects>((objectData) =>
                Objects.fromJson(objectData as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Error al cargar los objetos perdidos ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
