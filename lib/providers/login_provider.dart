import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  // Método para realizar el inicio de sesión
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      print('Error de inicio de sesión: $e');
    }
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}