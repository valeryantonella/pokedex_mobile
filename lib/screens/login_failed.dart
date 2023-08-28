import 'package:flutter/material.dart';
import 'package:pokedex_mobile/screens/login.dart';

class LoginFailedScreen extends StatelessWidget {
  static const routeName = '/login-failed';
  const LoginFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Falla al iniciar sesion'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Regresar a inicio de sesion',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, LoginScreen.routeName),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Volver a Intentar',
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
