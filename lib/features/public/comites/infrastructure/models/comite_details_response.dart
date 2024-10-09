// To parse this JSON data, do
//
//     final comiteDetails = comiteDetailsFromJson(jsonString);

import 'dart:convert';

ComiteDetailsResponse comiteDetailsFromJson(String str) =>
    ComiteDetailsResponse.fromJson(json.decode(str));

String comiteDetailsToJson(ComiteDetailsResponse data) =>
    json.encode(data.toJson());

class ComiteDetailsResponse {
  final Data data;

  ComiteDetailsResponse({
    required this.data,
  });

  factory ComiteDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ComiteDetailsResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final String type;
  final String nombre;
  final String? slug;
  final String descripcion;
  final String? imagenportada;
  final String? imagenbanner;

  Data({
    required this.id,
    required this.type,
    required this.nombre,
    required this.slug,
    required this.descripcion,
    required this.imagenportada,
    required this.imagenbanner,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        nombre: json["nombre"],
        slug: json["nombre"],
        descripcion: json["descripcion"],
        imagenportada: json["imagenportada"] ?? '',
        imagenbanner: json["imagenbanner"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagenportada": imagenportada,
        "imagenbanner": imagenbanner,
      };
}
