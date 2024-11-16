import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:3000';
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _token;

  bool isLoggedIn() {
    return _token != null;
  }

  Future<void> handleSuccessfulLogin(
      String accessToken, String refreshToken) async {
    _token = accessToken;
    await saveTokens(accessToken, refreshToken);
  }

  Future<void> logout() async {
    _token = null;
    await StorageService().deleteToken();
    // También deberías eliminar el refresh token
    await StorageService().deleteRefreshToken();
  }

  // Método para inicializar el estado de autenticación al iniciar la app
  Future<void> initializeAuth() async {
    final token = await StorageService().getToken();
    if (token != null) {
      // Aquí podrías validar el token con el backend si lo deseas
      _token = token;
    }
  }

  // Método para obtener el token actual
  String? get token => _token;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
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
      return {
        'success': false,
        'message': 'Error en el formato de la respuesta $e',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión. Intenta nuevamente. $e',
      };
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await StorageService().saveToken(accessToken);
    await StorageService().saveRefreshToken(refreshToken);
  }
}
