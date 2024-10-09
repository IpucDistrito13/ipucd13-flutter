// To parse this JSON data, do
//
//     final galeriaByUsuarioResponse = galeriaByUsuarioResponseFromJson(jsonString);

import 'dart:convert';

GaleriaByUsuarioResponse galeriaByUsuarioResponseFromJson(String str) =>
    GaleriaByUsuarioResponse.fromJson(json.decode(str));

String galeriaByUsuarioResponseToJson(GaleriaByUsuarioResponse data) =>
    json.encode(data.toJson());

class GaleriaByUsuarioResponse {
  final List<GaleriaByUsuarioServer> data;

  GaleriaByUsuarioResponse({
    required this.data,
  });

  factory GaleriaByUsuarioResponse.fromJson(Map<String, dynamic> json) =>
      GaleriaByUsuarioResponse(
        data: List<GaleriaByUsuarioServer>.from(
            json["data"].map((x) => GaleriaByUsuarioServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GaleriaByUsuarioServer {
  final String uuid;
  final String? imagen;
  final String createdAt;

  GaleriaByUsuarioServer({
    required this.uuid,
    required this.imagen,
    required this.createdAt,
  });

  factory GaleriaByUsuarioServer.fromJson(Map<String, dynamic> json) =>
      GaleriaByUsuarioServer(
        uuid: json["uuid"],
        imagen: json["imagen"] ?? '',
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "imagen": imagen,
        "created_at": createdAt,
      };
}
