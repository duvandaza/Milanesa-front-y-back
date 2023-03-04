import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milanesa/screens/usuario/carrito_screen.dart';
import 'package:milanesa/screens/usuario/opciones_screen.dart';
import 'package:milanesa/screens/usuario/pedidos_screen.dart';
import 'package:milanesa/screens/usuario/productos_user_screen.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {

  final List<Widget> page = [ProductosUserScreen(), CarritoScreen(), PedidosUserScreen(), OpcionesPage()];
  int _intPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_intPage],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        backgroundColor: const Color(0xFFFCF8E8),
        activeColor: const Color(0xFFFDF7861),
        color: const Color(0xFFFDF7861),
        items: const [
          TabItem(icon: FontAwesomeIcons.drumstickBite),
          TabItem(icon: FontAwesomeIcons.cartShopping),
          TabItem(icon: FontAwesomeIcons.clipboard),
          TabItem(icon: FontAwesomeIcons.userGear),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            _intPage = i;
          });
        } 
      ),
    );
  }
}