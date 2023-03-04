import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milanesa/models/producto_model.dart';
import 'package:milanesa/provider/producto_form_provider.dart';
import 'package:milanesa/screens/admin/home_admin_screen.dart';
import 'package:milanesa/services/producto_service.dart';
import 'package:milanesa/widgets/button_global.dart';
import 'package:milanesa/widgets/dropdow.dart';
import 'package:milanesa/widgets/top_page.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/input.dart';

class ModificarProducto extends StatelessWidget {
  const ModificarProducto({super.key, required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const TopPage(titulo: 'Modificar Producto',),
              ChangeNotifierProvider(
                create: ( _ ) => ProductoFormProvider(),
                child: _Form(producto: producto),
              ),
            ],
          ),
        ),
      )
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

  TextEditingController nameController = TextEditingController();
  TextEditingController catidadController = TextEditingController();
  TextEditingController precioController= TextEditingController();
  TextEditingController descripcionController= TextEditingController();
  TextEditingController presentacionController= TextEditingController();
  TextEditingController categoriaController= TextEditingController();
  final List presentacion = ['LB','KL'];


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.producto.name);
    catidadController = TextEditingController(text: widget.producto.cantidad);
    precioController= TextEditingController(text: widget.producto.precio);
    descripcionController= TextEditingController(text: widget.producto.descripcion);
    presentacionController= TextEditingController(text: widget.producto.presentacion);
    categoriaController= TextEditingController(text: widget.producto.categoria);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final productForm = Provider.of<ProductoFormProvider>(context);
    final producto = productForm.producto;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: productForm.key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: productForm.validForm,
        child: Column(
          children: [ 
            Input(
              controller: nameController,
              placeholder: 'Nombre producto',
              keyboardType: TextInputType.name,
              onChange: (value) => producto.name = value,
              validator: (value) {
                return value!.length < 4 ? 'No puede contener menos de 4 caracteres' : null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Input(
                    controller: catidadController,
                    placeholder: 'Cantidad',
                    keyboardType: TextInputType.number,
                    isInt: true,
                    onChange: (value) => producto.cantidad = value,
                    validator: (value) {
                      final parse = int.tryParse(value!) ?? 0;
                      return parse > 200 || parse < 1 ? 'Cantidad no valida' : null;
                    },
                  ),
                ),
                Expanded(
                  child: Input(
                    controller: precioController,
                    placeholder: 'Precio',
                    keyboardType: TextInputType.number,
                    isInt: true,
                    onChange: (value) => producto.precio = value,
                    validator: (value) {
                      final parse = int.tryParse(value!) ?? 0;
                      return parse < 1 ? 'Cantidad no valida' : null;
                    },
                  ),
                )  
              ],
            ),
            Input(
              controller: descripcionController,
              placeholder: 'Descripción',
              keyboardType: TextInputType.name,
              onChange: (value) => producto.descripcion = value,
              maxLinea: 3,
              validator: (value) {
                return value!.length < 6 ? 'No puede contener menos de 6 caracteres' : null;
              },
            ),
            Dropdown(data: presentacion,
              tipo: 'Presentación',
              onChange: (value) => producto.presentacion = value!,
              validator: (value) {
                return producto.presentacion != '' ? null : 'Seleccion una presentación';
              },
            ),
            Input(
              controller: categoriaController,
              placeholder: 'Categoria',
              keyboardType: TextInputType.name,
              onChange: (value) => producto.categoria = value,
              validator: (value) {
                return value!.length < 2 ? 'No puede contener menos de 2 caracteres' : null;
              },
            ),
            const SizedBox(height: 20,),
            ButtonGlobal(label: 'Modificar', 
              width: 0.4,
              onPressed: productForm.isValid ? () async {
                FocusManager.instance.primaryFocus?.unfocus();

                final dataProducto = Producto(
                  id: widget.producto.id,
                  name: producto.name == '' ? widget.producto.name : producto.name,
                  cantidad: producto.cantidad == '' ? widget.producto.cantidad : producto.cantidad,
                  precio: producto.precio == '' ? widget.producto.precio : producto.precio,
                  descripcion: producto.descripcion == '' ? widget.producto.descripcion : producto.descripcion,
                  presentacion: producto.presentacion == '' ? widget.producto.presentacion : producto.presentacion,
                  categoria: producto.categoria == '' ? widget.producto.categoria : producto.categoria,
                  url: widget.producto.url
                ); 
                final productoService = Provider.of<ProductoService>(context, listen:false);
                final validation = await productoService.updateProducto(dataProducto);
                if(validation) {
                  Get.offAll(HomeAdminScreen());
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'OK!',
                    text: 'Producto modificado Correctamente'
                  );
                } else{
                  print('algo paso');
                }
              } : null,
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
