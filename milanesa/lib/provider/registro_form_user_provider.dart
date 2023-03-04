import 'package:flutter/material.dart';
import 'package:milanesa/models/usuario_model.dart';

class RegistroUserFormProvider with ChangeNotifier {

  final key = GlobalKey<FormState>();

  Usuario user = Usuario(id: '', name: '', direccion: '', correo: '', telefono: '');


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isValid = false;
  bool get isValid => _isValid;
  set isValid (bool value) {
    _isValid = value;
    notifyListeners();
  }


  bool isValidForm(){
    return key.currentState?.validate() ?? false;
  }

  validForm() {
    isValid = key.currentState?.validate() ?? false;
  }
  
}