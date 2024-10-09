// To parse this JSON data, do
//
//     final congregacionesServerResponse = congregacionesServerResponseFromJson(jsonString);

import 'dart:convert';

import '../infrastructure.dart';

CongregacionesServerResponse congregacionesServerResponseFromJson(String str) =>
    CongregacionesServerResponse.fromJson(json.decode(str));

String congregacionesServerResponseToJson(CongregacionesServerResponse data) =>
    json.encode(data.toJson());

class CongregacionesServerResponse {
  final List<CongregacionServer> data;

  CongregacionesServerResponse({
    required this.data,
  });

  factory CongregacionesServerResponse.fromJson(Map<String, dynamic> json) =>
      CongregacionesServerResponse(
        data: List<CongregacionServer>.from(
            json["data"].map((x) => CongregacionServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
