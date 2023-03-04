import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    Key? key, required this.titulo,
  }) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Text(titulo, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
    );
  }
}