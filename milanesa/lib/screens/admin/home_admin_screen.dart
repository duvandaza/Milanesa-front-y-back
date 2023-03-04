import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milanesa/screens/admin/agregar_producto.dart';
import 'package:milanesa/screens/admin/pedidos_screens.dart';
import 'package:milanesa/screens/admin/productos_screens.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {

  final List<Widget> page = [ const ProductosScreen(), const PedidosScreen(), const AgregarProducto()];
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
          TabItem(icon: FontAwesomeIcons.clipboard),
          TabItem(icon: FontAwesomeIcons.circlePlus),
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