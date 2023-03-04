import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milanesa/models/carrito_model.dart';
import 'package:milanesa/models/producto_model.dart';
import 'package:milanesa/provider/detalle_form_provider.dart';
import 'package:milanesa/screens/usuario/home_user_screen.dart';
import 'package:milanesa/services/carrito_service.dart';
import 'package:milanesa/services/usuario_service.dart';
import 'package:milanesa/widgets/button_global.dart';
import 'package:milanesa/widgets/dropdow.dart';
import 'package:milanesa/widgets/input.dart';
import 'package:milanesa/widgets/text_precio.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class DetalleProductoScreen extends StatelessWidget {
  const DetalleProductoScreen({super.key, required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF94B49F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopImage(size: size, image: producto.url,),
            Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.04, horizontal: size.width * 0.06 ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFCF8E8),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
              ),
              child: ChangeNotifierProvider(
                create: (context) => DetalleFormProvider(),
                child: _Form(producto: producto,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key, required this.producto,
  }) : super(key: key);

  final Producto producto;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  
  final cantidadController = TextEditingController();
  final List peso = ['Kilo', 'Libra'];

  @override
  Widget build(BuildContext context) {

    final prod = widget.producto;
    final detalleForm = Provider.of<DetalleFormProvider>(context);
    final size = MediaQuery.of(context).size;

    return Form(
      key: detalleForm.key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: detalleForm.validForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: Text(prod.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xFFDF7861)),)
              ),
              TextPrecio(sizePeso: 15, precio: prod.precio, peso: prod.presentacion, sizePrecio: 28),
            ],
          ),
          const SizedBox(height: 15,),
          const Text('Detalles', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, )),
          const SizedBox(height: 10,),
          Text(prod.descripcion, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15,)),
          const SizedBox(height: 10,),
          const Text('Peso:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, )),
          Dropdown2(
            data: peso,
            onChange: (value) => detalleForm.peso = value!,
            validator: (value) {
              return detalleForm.peso != '' ? null : 'Seleccione';
            },
          ),
          Input(
            controller: cantidadController,
            placeholder: 'Cantidad',
            keyboardType: TextInputType.number,
            isInt: true,
            onChange: (value) => detalleForm.cantidad = value,
            validator: (value) {
              final parse = int.tryParse(value!) ?? 0;
              final cantidad = int.tryParse(prod.cantidad);
              return parse > cantidad! || parse < 1 ? 'Cantidad Maxima $cantidad' : null;
            },
          ),
          const SizedBox(height: 10,),
          Center(
            child: ButtonGlobalIcon(label: 'Añadir al carrito', 
              width: 0.7,
              onPressed: detalleForm.isValid ? () async{
                FocusManager.instance.primaryFocus?.unfocus();
                final userService = Provider.of<UsuarioService>(context, listen: false);
                double precio = 0;
                int? cantidad = int.tryParse(detalleForm.cantidad);
                double costo = double.parse(prod.precio);
                if(prod.presentacion == 'KL'){
                  if(detalleForm.peso == 'Libra'){
                    precio = cantidad! / 2 * costo;
                  }else{
                    precio = cantidad! * costo;
                  }
                }else if(prod.presentacion == 'LB'){
                  if(detalleForm.peso == 'Kilo'){
                    precio = cantidad! * 2 * costo;
                  }
                  else{
                    precio = cantidad! * costo;
                  }
                }
                Carrito carrito = Carrito(id: '',
                  idUser: userService.user.id,
                  nameProducto: prod.name,
                  cantidad: detalleForm.cantidad,
                  precio: precio,
                  presentacion: detalleForm.peso,
                  url: prod.url,
                );
                final carritoService = Provider.of<CarritoService>(context, listen: false);
                final validation = await carritoService.creatCarrito(carrito);
                if(validation) {
                  Get.off(HomeUserScreen()); 
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'OK!',
                  text: 'Producto agregado al carrito'
                );
                }else{
                 print('algo paso');
                } 
              }: null
            ),
          )
        ],
      ),
    );
  }
}

class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
    required this.size, required this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: size.height * 0.4,
      child: Image(image: NetworkImage(image),),
    );
  }
}