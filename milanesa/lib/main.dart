import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:milanesa/services/carrito_service.dart';
import 'package:milanesa/services/producto_service.dart';
import 'package:milanesa/services/usuario_service.dart';
import 'package:provider/provider.dart';

import 'package:milanesa/services/login_service.dart';

import 'package:milanesa/screens/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => LoginService()),
        ChangeNotifierProvider( create: (_) => UsuarioService()),
        ChangeNotifierProvider( create: (_) => ProductoService(), lazy: false,),
        ChangeNotifierProvider( create: (_) => CarritoService()),
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Milanesa App',
        home: LoginScreen(),
      )
    );
  }
}