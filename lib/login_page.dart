import 'package:flutter/material.dart';
import 'api_service.dart';
import 'welcome_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final result = await _apiService.loginUser(
        _usernameEmailController.text,
        _passwordController.text,
      );

      if (result != null && result.containsKey("token")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WelcomePage(username: _usernameEmailController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result?['error'] ?? "Error desconocido")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de Sesión')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameEmailController,
                decoration: InputDecoration(labelText: 'Usuario o Correo'),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('¿No tienes cuenta? Regístrate.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
