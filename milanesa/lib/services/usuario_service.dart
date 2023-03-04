import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:milanesa/models/usuario_model.dart';
import 'package:milanesa/services/login_service.dart';

class UsuarioService extends ChangeNotifier{
  
  late Usuario _usuario;
  final doc = FirebaseFirestore.instance;
  final loginService = LoginService();

  Usuario get user {
    return _usuario;
  }

  set user(Usuario u){
    _usuario = u;
    notifyListeners();
  }

  Future <bool> createUser(Usuario dataUser, String passw) async {

    final res = await loginService.userAuth(dataUser.correo, passw);
    
    if(res.validator){
      final docUser = doc.collection('users').doc();
      dataUser.id = docUser.id;
      await docUser.set(dataUser.toMap());
      user = dataUser;
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  Future <String> searchUserByEmail(String email) async {

    final res = await doc.collection('users')
    .where('correo', isEqualTo: email).get();
    user = Usuario.fromMap(res.docs[0].data());
    notifyListeners();
    return user.id;
  }

  Future<bool> updateUser(Usuario dataUser) async {

    await doc.collection('users').doc(dataUser.id)
    .set(dataUser.toMap());
    user = dataUser;
    notifyListeners();
    return true;

  }

}