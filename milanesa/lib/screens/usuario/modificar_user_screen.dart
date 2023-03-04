import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milanesa/models/usuario_model.dart';
import 'package:milanesa/provider/registro_form_user_provider.dart';
import 'package:milanesa/screens/login.dart';
import 'package:milanesa/screens/usuario/home_user_screen.dart';
import 'package:milanesa/services/usuario_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../widgets/button_global.dart';
import '../../widgets/input.dart';


class ModificarUserScreen extends StatelessWidget {
  const ModificarUserScreen ({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userService = Provider.of<UsuarioService>(context);
    final user = userService.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFF94B49F),
              height: size.height * 0.3,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.15),
              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              decoration: const BoxDecoration(
                color: Color(0xFFFCF8E8),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80), topRight:Radius.circular(80)),
              ),
              child: Column(
                children: [
                  const Text('Modificar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xFFDF7861)),),
                  const SizedBox(height: 10,),
                  ChangeNotifierProvider(
                    create: ( _ ) => RegistroUserFormProvider(),
                    child: _Form(user: user),
                  ),
                  const SizedBox(height: 10,),
                  TextButton(
                    onPressed: () => Get.to(LoginScreen()),
                    child: const Text('¿Ya tienes cuenta?', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFFDF7861)),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key, required this.user,
  }) : super(key: key);

  final Usuario user;

  @override
  State<_Form> createState() => _FormState();
}
class _FormState extends State<_Form> {

  TextEditingController nameController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  String pass = '';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    direccionController = TextEditingController(text: widget.user.direccion);
    telefonoController = TextEditingController(text: widget.user.telefono);
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final registroForm = Provider.of<RegistroUserFormProvider>(context);
    final userForm = registroForm.user;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF94B49F),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const[
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(1, 4),
                      blurRadius: 1
                  )
                ]
              ),
              child: Form(
                key: registroForm.key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: registroForm.validForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      height: size.height * 0.05,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 30,),
                        child: Center(child: Text(widget.user.correo, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)),
                      ),
                    ),
                    Input(
                      controller: nameController,
                      placeholder: 'Nombre',
                      keyboardType: TextInputType.name,
                      onChange: (value) => userForm.name = value,
                      validator: (value) {
                       return value!.length < 4 ? 'No puede contener menos de 4 caracteres' : null;
                      },
                    ),
                    Input(
                      controller: direccionController,
                      placeholder: 'Dirección',
                      keyboardType: TextInputType.streetAddress,
                      onChange: (value) => userForm.direccion = value,
                      validator: (value) {
                       return value!.length < 6 ? 'No puede contener menos de 6 caracteres' : null;
                      },
                    ),
                    Input(
                      controller: telefonoController,
                      placeholder: 'Telefono',
                      keyboardType: TextInputType.phone,
                      onChange: (value) => userForm.telefono = value,
                      isInt: true,
                      validator: (value) {
                       return value!.length != 10 ? 'Telefono invalido' : null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ButtonGlobal(
              label: 'Modifcar datos',
              width: 0.5,
              onPressed: registroForm.isValid ? () async{
                FocusManager.instance.primaryFocus?.unfocus();
                final userService = Provider.of<UsuarioService>(context, listen: false);
                final dataUser = Usuario(id: widget.user.id,
                  name: userForm.name == '' ? widget.user.name : userForm.name,
                  direccion: userForm.direccion == '' ? widget.user.direccion : userForm.direccion,
                  correo: widget.user.correo,
                  telefono: userForm.telefono == '' ? widget.user.telefono : userForm.telefono
                );
                final validation = await userService.updateUser(dataUser);
                if(validation) {
                  Get.offAll(HomeUserScreen());
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'OK!',
                    text: 'Datos modificados Correctamente'
                  );
                }else{
                  print('algo paso');
                }
              } : null,
            )
          ],
        ),
      ),
    );
  }
}