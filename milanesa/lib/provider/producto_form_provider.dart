import 'package:flutter/material.dart';
import 'package:milanesa/models/producto_model.dart';

class ProductoFormProvider with ChangeNotifier {

  final key = GlobalKey<FormState>();

  Producto producto = Producto(
    id: '',
    name: '',
    cantidad: '',
    precio: '',
    descripcion: '',
    presentacion: '',
    categoria: '',
    url: ''
  );

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