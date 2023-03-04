import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milanesa/provider/login_form_provider.dart';
import 'package:milanesa/screens/home_screen.dart';
import 'package:milanesa/screens/usuario/registro_user_screen.dart';
import 'package:milanesa/services/carrito_service.dart';
import 'package:milanesa/services/login_service.dart';
import 'package:milanesa/services/usuario_service.dart';
import 'package:milanesa/widgets/button_global.dart';
import 'package:milanesa/widgets/input.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xFFDF7861)),),
              SizedBox(
                width: size.width * 0.5,
                child: const Image(image: AssetImage('assets/logo.png'),),
              ),
              ChangeNotifierProvider(
                create: ( _ ) => LoginFormProvider(),
                child: _Form(),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: () => Get.to(RegisterUserScreen()),
                child: const Text('Registrate Aqui!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFFDF7861)),),
              )
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Center(
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
              key: loginForm.key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: loginForm.validForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Input(
                    controller: emailController,
                    placeholder: 'Correo',
                    keyboardType: TextInputType.emailAddress,
                    onChange: (value) => loginForm.email = value,
                    validator: (value) {
                      const pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp  = RegExp(pattern);
                      return regExp.hasMatch(value ?? '')
                      ? null
                      : 'no es un correo válido';
                    },
                  ),
                  Input(
                    controller: passwordController,
                    placeholder: 'Contraseña',
                    keyboardType: TextInputType.text,
                    onChange: (value) => loginForm.password = value,
                    isPassword: true,
                    validator: (value) {
                      return value!.length < 6 ? 'No puede contener menos de 6 caracteres' : null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          ButtonGlobal(
            label: 'Iniciar sesion',
            width: 0.5,
            onPressed: loginForm.isValid ? () async{
              FocusManager.instance.primaryFocus?.unfocus();
              final loginService = Provider.of<LoginService>(context, listen: false);
              final userService = Provider.of<UsuarioService>(context, listen: false);
              final carritoService = Provider.of<CarritoService>(context, listen: false);
              bool res = await loginService.login(loginForm.email, loginForm.password);
              if(res) {
                if(loginForm.email != 'admin@user.com') {
                  final id = await userService.searchUserByEmail(loginForm.email);
                  await carritoService.searchCarritoById(id);
                } 
                
                Get.offAll(HomeScreen(validatorUser: loginForm.email));
              }else{
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Error!',
                  text: loginService.exception
                );
              }
            } : null,
          )
        ],
      ),
    );
  }
}