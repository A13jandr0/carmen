import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:5071/api/Auth";

  // Registro de Usuario
  Future<String> registerUser(String username, String password, String email,
      String nombres, String apellidos, int idRol) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Username': username,
        'Password': password,
        'Email': email,
        'Nombres': nombres,
        'Apellidos': apellidos,
        'IdRol': idRol,
      }),
    );

    if (response.statusCode == 200) {
      return "Usuario registrado exitosamente.";
    } else {
      final error = jsonDecode(response.body);
      return "Error: ${error['message'] ?? 'No se pudo registrar el usuario'}";
    }
  }

  // Inicio de Sesión
  Future<Map<String, dynamic>?> loginUser(
      String usernameOrEmail, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Username': usernameOrEmail,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Retorna los datos del usuario y token
    } else {
      final error = jsonDecode(response.body);
      return {"error": error['message'] ?? "Credenciales incorrectas"};
    }
  }
}
