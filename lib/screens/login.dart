import 'package:flutter/material.dart';
import 'package:pokedex_mobile/main.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:pokedex_mobile/screens/login_failed.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Inicio de Sesion'),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.person,
                color: Colors.blue,
                size: 180,
              ),
              TextField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Provider.of<LoginProvider>(context, listen: false).login(
                    _emailController.text,
                    _passwordController.text,
                  );

                  if (Provider.of<LoginProvider>(context, listen: false).user !=
                      null) {
                    Navigator.pushNamed(context, MainWidget.routeName);
                  } else {
                    print('No se puede iniciar sesion, intete nuevamente.');
                    Navigator.pushNamed(context, LoginFailedScreen.routeName);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
