import 'dart:convert';

class Producto {
    Producto({
      required this.id,
      required this.name,
      required this.cantidad,
      required this.precio,
      required this.descripcion,
      required this.presentacion,
      required this.categoria,
      required this.url,
    });

    String id;
    String name;
    String cantidad;
    String precio;
    String descripcion;
    String presentacion;
    String categoria;
    String url;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        name: json["name"],
        cantidad: json["cantidad"],
        precio: json["precio"],
        descripcion: json["descripcion"],
        presentacion: json["presentacion"],
        categoria: json["categoria"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "cantidad": cantidad,
        "precio": precio,
        "descripcion": descripcion,
        "presentacion": presentacion,
        "categoria": categoria,
        "url": url,
    };
}
