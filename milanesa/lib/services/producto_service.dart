import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:milanesa/services/login_service.dart';

import '../models/producto_model.dart';

class ProductoService extends ChangeNotifier{
  
  List<Producto> _productos = [];
  final doc = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final loginService = LoginService();

  List<Producto> get productos{
    return _productos;
  }

  set productos(List<Producto> p){
    _productos = p;
    notifyListeners();
  }

  ProductoService(){
    getProductos();
  }

  Future <bool> createProducto(Producto prod, File image) async {
    
    try {
      final docProducto = doc.collection('productos').doc();
      prod.id = docProducto.id;
      await docProducto.set(prod.toMap());
      final res = await addImage(image, prod.id);
      prod.url = res;
      final validation = await updateProducto(prod);
      if(validation){
        productos.add(prod);
      }
      return validation;
    } catch (e) {
      return false;
    }
  }

  Future <List<Producto>> getProductos() async {
    List<Producto> prod = [];
    final res = await doc.collection('productos').get();
    for(var p in res.docs){
      prod.add(Producto.fromMap(p.data()));
    }
    productos = prod;
    return prod;
  }

  Future <String> addImage(File image, String id) async{

    final mountainImagesRef = storageRef.child(id);
    await mountainImagesRef.putFile(image);
    final url = await mountainImagesRef.getDownloadURL();
    return url;
  }

  Future deleteProducto(String id) async {
    await doc.collection('productos').doc(id).delete();
    productos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future <bool> updateProducto(Producto prod) async {
    
    try {
      await doc.collection('productos').doc(prod.id).set(prod.toMap());
      final posicion = productos.indexWhere((element) => element.id == prod.id);
      productos[posicion] = prod;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}