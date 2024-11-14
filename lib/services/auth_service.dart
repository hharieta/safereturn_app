import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('Intentando login con email: $email'); // Debug

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email.trim(),
          'password': password.trim(),
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final accessToken = responseData['access_token'];
        final refreshToken = responseData['refresh_token'];

        // Guardar tokens
        await saveTokens(accessToken, refreshToken);

        return {
          'success': true,
          'data': {
            'access_token': accessToken,
            'refresh_token': refreshToken,
            'sub': responseData['sub'],
          },
        };
      } else {
        return {
          'success': false,
          'message': 'Credenciales inválidas',
        };
      }
    } on FormatException catch (e) {
      print('Error de formato: $e');
      return {
        'success': false,
        'message': 'Error en el formato de la respuesta',
      };
    } catch (e) {
      print('Error en login: $e');
      return {
        'success': false,
        'message': 'Error de conexión. Intenta nuevamente.',
      };
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await StorageService().saveToken(accessToken);
    await StorageService().saveRefreshToken(refreshToken);
  }

  Future<void> handleSuccessfulLogin(
      String accessToken, String refreshToken) async {
    await saveTokens(accessToken, refreshToken);
    // Aquí puedes agregar más lógica relacionada con el login si es necesario
    // Por ejemplo: guardar información del usuario, actualizar estado global, etc.
  }
}
