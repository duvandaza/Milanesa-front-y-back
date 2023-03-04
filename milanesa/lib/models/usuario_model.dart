import 'dart:convert';

class Usuario {
    Usuario({
      required this.id,
      required this.name,
      required this.direccion,
      required this.correo,
      required this.telefono,
    });

    String id;
    String name;
    String direccion;
    String correo;
    String telefono;

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        name: json["name"],
        direccion: json["direccion"],
        correo: json["correo"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "direccion": direccion,
        "correo": correo,
        "telefono": telefono,
    };
}
