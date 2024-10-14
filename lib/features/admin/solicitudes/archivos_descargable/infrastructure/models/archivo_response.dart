import 'dart:convert';
import '/features/admin/solicitudes/archivos_descargable/infrastructure/models/archivo_descargable_server.dart';

ArchivosDescargableResponse archivosDescargableResponseFromJson(String str) =>
    ArchivosDescargableResponse.fromJson(json.decode(str));

String archivosDescargableResponseToJson(ArchivosDescargableResponse data) =>
    json.encode(data.toJson());

class ArchivosDescargableResponse {
  final List<ArchivoDescargableServer> data;

  ArchivosDescargableResponse({
    required this.data,
  });

  factory ArchivosDescargableResponse.fromJson(Map<String, dynamic> json) =>
      ArchivosDescargableResponse(
        data: List<ArchivoDescargableServer>.from(
            json["data"].map((x) => ArchivoDescargableServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
