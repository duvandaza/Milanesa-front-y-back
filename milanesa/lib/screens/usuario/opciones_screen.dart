import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:milanesa/screens/login.dart';
import 'package:milanesa/screens/usuario/modificar_user_screen.dart';

import '../../widgets/top_page.dart';


class OpcionesPage extends StatelessWidget {
  const OpcionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: Column(
          children: [
            const TopPage(titulo: 'Opciones',),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                title: const Text('Modificar datos'),
                leading: const FaIcon(FontAwesomeIcons.userPen),
                iconColor: Colors.blue,
                onTap: () {
                  Get.to(ModificarUserScreen());
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                title: const Text('Modificar datos'),
                leading: const FaIcon(FontAwesomeIcons.rightFromBracket),
                iconColor: Colors.red,
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(const LoginScreen());
                },
              ),
            ),
          ],
        ),
      )
   );
  }
}