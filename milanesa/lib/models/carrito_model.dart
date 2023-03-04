
import 'dart:convert';

class Carrito {
    Carrito({
      required this.id,
      required this.idUser,
      required this.nameProducto,
      required this.cantidad,
      required this.precio,
      required this.presentacion,
      required this.url,
    });

    String id;
    String idUser;
    String nameProducto;
    String cantidad;
    double precio;
    String presentacion;
    String url;

    factory Carrito.fromJson(String str) => Carrito.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Carrito.fromMap(Map<String, dynamic> json) => Carrito(
        id: json["id"],
        idUser: json["id_user"],
        nameProducto: json["name_producto"],
        cantidad: json["cantidad"],
        precio: json["precio"].toDouble(),
        presentacion: json["presentacion"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "id_user": idUser,
        "name_producto": nameProducto,
        "cantidad": cantidad,
        "precio": precio,
        "presentacion": presentacion,
        "url": url,
    };
}
