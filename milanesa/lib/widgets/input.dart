import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {

  final TextEditingController controller;
  final Function(String value ) onChange; 
  final String? Function(String? value ) validator; 
  final String placeholder;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool? isInt;
  final int? maxLinea;

  const Input({super.key, 
    required this.controller, 
    required this.onChange, 
    required this.validator,  
    required this.placeholder, 
    this.isPassword = false, 
    required this.keyboardType, 
    this.isInt = false, 
    this.maxLinea = 1,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: size.width * 0.025),
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.012),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        maxLines: maxLinea,
        inputFormatters: isInt! ? [
          FilteringTextInputFormatter.digitsOnly
        ] : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: placeholder,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.blue
            )
          ),
        ),
        onChanged: onChange,
        validator: validator,
      ),
    );
  }
}
