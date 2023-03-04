import 'dart:io';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milanesa/provider/producto_form_provider.dart';
import 'package:milanesa/screens/admin/home_admin_screen.dart';
import 'package:milanesa/services/producto_service.dart';
import 'package:milanesa/widgets/button_global.dart';
import 'package:milanesa/widgets/dropdow.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../widgets/input.dart';

class AgregarProducto extends StatelessWidget {
  const AgregarProducto({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              TopPage(size: size),
              ChangeNotifierProvider(
                create: ( _ ) => ProductoFormProvider(),
                child: const _Form(),
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
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final nameController = TextEditingController();
  final catidadController = TextEditingController();
  final precioController= TextEditingController();
  final descripcionController= TextEditingController();
  final presentacionController= TextEditingController();
  final categoriaController= TextEditingController();
  final List presentacion = ['LB','KL'];
  final picker = ImagePicker();
  File? image; 

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
            InkWell(
              onTap: () async{
                FocusManager.instance.primaryFocus?.unfocus();
                final XFile? pickerImage = await picker.pickImage(source: ImageSource.gallery);
                if (pickerImage == null) {
                  return print('no selecciono Imagen');
                }
                image = File(pickerImage.path);
                setState(() {});
              },
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.15,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const[
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(1, 4),
                        blurRadius: 3
                    ),
                  ]
                ),
                child: image == null ? 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.image, size: 60, color: Color(0xFFDF7861),),
                      SizedBox(height: 5,),
                      Text('Subir imagen', style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFDF7861)),)
                    ],
                  )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
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
            ButtonGlobal(label: 'Agregar', 
              width: 0.4,
              onPressed: productForm.isValid ? () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if(image == null) return print('no hay imagen'); 
                final productoService = Provider.of<ProductoService>(context, listen:false);
                bool validation = await productoService.createProducto(producto, image!);
                if(validation) {
                  Get.offAll(const HomeAdminScreen());
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'OK!',
                    text: 'Producto agregado Correctamente'
                  );
                }else{
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


class TopPage extends StatelessWidget {
  const TopPage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Agregar Producto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        const SizedBox(width: 10,),
        SizedBox(
          width: size.width * 0.3,
          child: const Image(image: AssetImage('assets/logo.png'),),
        ),
      ],
    );
  }
}