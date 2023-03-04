import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milanesa/models/carrito_model.dart';
import 'package:milanesa/widgets/button_global.dart';
import 'package:milanesa/widgets/top_page.dart';
import 'package:provider/provider.dart';

import '../../services/carrito_service.dart';
import '../../widgets/text_card.dart';


class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final carritoService = Provider.of<CarritoService>(context, listen: false);
    final carrito = carritoService.carritos;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SafeArea(
        child: Column(
          children: [
            const TopPage(titulo: 'Carrito de compra',),
            SizedBox(
              height: size.height * 0.63,
              child: carrito.isNotEmpty ?
              ListView.builder(
                itemCount: carrito.length,
                itemBuilder: (BuildContext context, int index ){
                  return CardCarrito(size: size, carrito: carrito[index],);
                }  
              )
              : Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Image(
                  image: AssetImage('assets/car.png')
                ),
              ),
            ),
            carrito.isNotEmpty ? Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Total : ${carritoService.precioTotal}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    ),
                    Center(
                      child: ButtonGlobal(label: 'Pedir', 
                        width: 0.4,
                        onPressed: () {
                        },
                      ),
                    )
                  ],
                ),
              ),
            ) : Container(),
          ],
        ),
      )
   );
  }
}


class CardCarrito extends StatelessWidget {
  const CardCarrito({
    Key? key,
    required this.size, required this.carrito,
  }) : super(key: key);

  final Size size;
  final Carrito carrito;

  @override
  Widget build(BuildContext context) {

    final carritoService = Provider.of<CarritoService>(context, listen: false);

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
              image: NetworkImage(carrito.url),
            )
          ),
          Container(
            width: size.width * 0.4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCard(titulo: carrito.nameProducto),
                TextCard(titulo: 'Cantidad: ${carrito.cantidad}'),
                TextCard(titulo:'Precio: ${carrito.precio} ${carrito.presentacion}' ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async{
               await carritoService.deleteCarrito(carrito.id);
            },
            icon: const FaIcon(FontAwesomeIcons.trash, size: 25, color: Colors.red,)
          )
        ],
      ),
    );
  }
}