import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:milanesa/models/producto_model.dart';
import 'package:milanesa/screens/detalle_producto_screen.dart';
import 'package:milanesa/services/usuario_service.dart';
import 'package:milanesa/widgets/top_page.dart';
import 'package:provider/provider.dart';

import '../../services/producto_service.dart';
import '../../widgets/text_precio.dart';


class ProductosUserScreen extends StatelessWidget {
  const ProductosUserScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final productoService = Provider.of<ProductoService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    final productos = productoService.productos;
    final usuario = usuarioService.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.locationDot),
                  SizedBox(width: 15,),
                  Text(usuario.direccion, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                ],
              ),
            ),
            const TopPage(titulo: 'Productos'),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20 ),
              child: const Text('Lista de productos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: GridView.builder(
                  itemCount: productos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: size.height * 0.2
                  ),
                  itemBuilder: (context, int index){
                    return InkWell(
                      onTap: () => Get.to(DetalleProductoScreen(producto: productos[index])),
                      child: CardUserProduct(size: size, producto: productos[index])
                    );
                  }
                ),
              )
            )
          ],
        )
     ),
   );
  }
}

class CardUserProduct extends StatelessWidget {
  const CardUserProduct({
    Key? key,
    required this.size, required this.producto,
  }) : super(key: key);

  final Size size;
  final Producto producto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 4),
            blurRadius: 1
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.1,
            width: size.width * 0.27,
            child: Image(image: NetworkImage(producto.url), fit: BoxFit.fill, )
          ),
          const SizedBox(height: 12,),
          Text(producto.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, overflow: TextOverflow.ellipsis),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5,),
          TextPrecio(peso: producto.presentacion, precio: producto.precio, sizePeso: 9, sizePrecio: 16,)
        ],
      ),
    );
  }
}

