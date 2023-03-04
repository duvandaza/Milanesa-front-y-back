import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key, required this.data, required this.tipo, required this.onChange, required this.validator});
  final List data;
  final String tipo;
  final Function(String? value ) onChange;
  final String? Function(String? value ) validator; 

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.tipo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          const SizedBox(height: 8,),
          DropdownButtonFormField(
            items: getOpcionesDropdown(),
            hint: const Text('Seleccione'),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10)
            ),
            isExpanded: true,
            onChanged: widget.onChange,
            validator: widget.validator,
          ),
          const SizedBox(height: 8,),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    
    List<DropdownMenuItem<String>> lista = [];

    widget.data.forEach((ruta) { 
      lista.add(DropdownMenuItem(
        child: Text(ruta),
        value: ruta,
      ));
    });
    return lista;
  }
}



class Dropdown2 extends StatefulWidget {
  const Dropdown2({super.key, required this.data, required this.onChange, required this.validator});
  final List data;
  final Function(String? value ) onChange;
  final String? Function(String? value ) validator; 

  @override
  State<Dropdown2> createState() => _Dropdown2State();
}

class _Dropdown2State extends State<Dropdown2> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: DropdownButtonFormField(
        items: getOpcionesDropdown(),
        hint: const Text('Seleccione'),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10)
        ),
        isExpanded: true,
        onChanged: widget.onChange,
        validator: widget.validator,
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    
    List<DropdownMenuItem<String>> lista = [];

    widget.data.forEach((ruta) { 
      lista.add(DropdownMenuItem(
        child: Text(ruta),
        value: ruta,
      ));
    });
    return lista;
  }
}