
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:milanesa/models/respuesta.dart';

class LoginService extends ChangeNotifier {

  final auth = FirebaseAuth.instance;
  String exception = '';
  
  Future <bool> login(String correo, String passw) async {
    
    try {
      final res = await auth.signInWithEmailAndPassword(email: correo, password: passw);
      final credencial = res.user;
      
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        exception = 'No existe un usuario con este correo';
      } else if (e.code == 'wrong-password') {
        exception = 'contraseña incorrecta';
      }
      notifyListeners();
      return false;
    }
  }

  Future <Res> userAuth(String email, String password) async {
    try {
      final res = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      return Res(validator: true, mensaje: 'Agregado exitosamente');
    } on FirebaseAuthException catch (e){
      if(e.code == 'weak-password') {
        return Res(validator: false, mensaje: 'La contraseña proporcionada es demasiado débil.');
      } else if (e.code == 'email-already-in-use') {
        return Res(validator: false, mensaje: 'La cuenta ya existe para ese correo electrónico.');
      }
      return Res(validator: false, mensaje: 'Error: $e');
    }

  }

}

