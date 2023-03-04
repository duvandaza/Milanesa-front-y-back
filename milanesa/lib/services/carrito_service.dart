
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/carrito_model.dart';


class CarritoService extends ChangeNotifier{
  
  List<Carrito> _carritos = [];
  final doc = FirebaseFirestore.instance;
  double _precioTotal = 0; 

  double get precioTotal{
    return _precioTotal;
  }

  set precioTotal(double p){
    _precioTotal = p;
    notifyListeners();
  }

  List<Carrito> get carritos {
    return _carritos;
  }

  set carritos(List<Carrito> c){
    _carritos = c;
    notifyListeners();
  }

  Future <bool> creatCarrito(Carrito carrito) async { 

    try {
      final doccarrito = doc.collection('carritos').doc();
      carrito.id = doccarrito.id;
      await doccarrito.set(carrito.toMap());
      _carritos.add(carrito);
      precioTotal += carrito.precio;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future <bool> deleteCarrito(String id) async {
    for( var car in carritos ){
      if( car.id == id ){
        precioTotal -= car.precio;
      }
    }
    carritos.removeWhere((e) => e.id == id);
    await doc.collection('carritos').doc(id).delete();
    notifyListeners();
    return true;
  }

  Future <bool> searchCarritoById(String id) async {
    carritos = [];
    final res = await doc.collection('carritos')
    .where('id_user', isEqualTo: id).get();
    for(var doc in res.docs){
      final car = Carrito.fromMap(doc.data());
      carritos.add(car);
      precioTotal += car.precio;
    }
    print(carritos.length);
    notifyListeners();
    return true;
  }

}