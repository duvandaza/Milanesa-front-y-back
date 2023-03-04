import 'package:flutter/material.dart';
import 'package:milanesa/screens/admin/home_admin_screen.dart';
import 'package:milanesa/screens/usuario/home_user_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.validatorUser});

  final String validatorUser;

  @override
  Widget build(BuildContext context) {
    return validatorUser == 'admin@user.com' ? HomeAdminScreen() : HomeUserScreen();
  }
}