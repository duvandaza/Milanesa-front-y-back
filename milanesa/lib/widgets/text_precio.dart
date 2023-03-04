import 'package:flutter/material.dart';


class TextPrecio extends StatelessWidget {
  const TextPrecio({
    Key? key,
     required this.sizePeso, required this.precio, required this.peso, required this.sizePrecio,
  }) : super(key: key);

  final String precio;
  final String peso;
  final double sizePrecio;
  final double sizePeso;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('\$$precio', style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: sizePrecio, color: const Color(0xFFDF7861),overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text('/$peso', style: TextStyle(fontWeight: FontWeight.w500, fontSize: sizePeso, color: Colors.black45),)
        ),
      ],
    );
  }
}