import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:milanesa/models/producto_model.dart';
import 'package:milanesa/screens/admin/modificar_producto_screen.dart';
import 'package:milanesa/services/producto_service.dart';
import 'package:provider/provider.dart';

import '../../widgets/text_card.dart';
import '../../widgets/top_page.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final productoService = Provider.of<ProductoService>(context);
    final productos = productoService.productos;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopPage(titulo: 'Productos',),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text('Lista de productos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardProduct(size: size, producto: productos[index],);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.size, required this.producto,
  }) : super(key: key);

  final Size size;
  final Producto producto;

  @override
  Widget build(BuildContext context) {

    final productoService = Provider.of<ProductoService>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 4),
            blurRadius: 1
          ),
        ]
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: size.width * 0.25,
            child: Image(
              image: NetworkImage(producto.url),
            )
          ),
          Container(
            width: size.width * 0.4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCard(titulo: producto.name),
                TextCard(titulo: 'Cantidad: ${producto.cantidad} ${producto.presentacion}'),
                TextCard(titulo:'Precio: ${producto.precio}'),
                TextCard(titulo:'Categoria: ${producto.categoria}'),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () async{
                  Get.to(ModificarProducto(producto: producto));
                },
                icon: const FaIcon(FontAwesomeIcons.squarePen, size: 30, color: Colors.blue,)
              ),
              IconButton(
                onPressed: () async{
                  await productoService.deleteProducto(producto.id);
                },
                icon: const FaIcon(FontAwesomeIcons.trash, size: 25, color: Colors.red,)
              ),
            ],
          )
        ],
      ),
    );
  }
}



