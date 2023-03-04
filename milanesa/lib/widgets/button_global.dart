import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({super.key, required this.label, required this.onPressed, required this.width});

  final String label;
  final void Function()? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * width,
      height: size.height * 0.06,
      child: MaterialButton(
        color: const Color(0xFF94B49F),
        disabledColor: Colors.grey,
        elevation: 2,
        highlightElevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),),
      ),
    );
  }
}


class ButtonGlobalIcon extends StatelessWidget {
  const ButtonGlobalIcon({super.key, required this.label, required this.onPressed, required this.width});

  final String label;
  final void Function()? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * width,
      height: size.height * 0.06,
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: MaterialButton(
        color: const Color(0xFFDF7861),
        disabledColor: Colors.grey,
        elevation: 2,
        highlightElevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}