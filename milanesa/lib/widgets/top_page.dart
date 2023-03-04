import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({
    Key? key, required this.titulo,
  }) : super(key: key);

  final String titulo;


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.5,
          child: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          )
        ),
        SizedBox(
        width: size.width * 0.4,
        child: const Image(image: AssetImage('assets/logo.png'),),
      ),
      ],
    );
  }
}