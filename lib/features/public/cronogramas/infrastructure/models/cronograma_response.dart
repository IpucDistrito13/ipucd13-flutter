// To parse this JSON data, do
//
//     final cronogramaResponse = cronogramaResponseFromJson(jsonString);

import 'dart:convert';

import '../infrastructure.dart';

CronogramaResponse cronogramaResponseFromJson(String str) =>
    CronogramaResponse.fromJson(json.decode(str));

String cronogramaResponseToJson(CronogramaResponse data) =>
    json.encode(data.toJson());

class CronogramaResponse {
  final List<CronogramaServer> data;

  CronogramaResponse({
    required this.data,
  });

  factory CronogramaResponse.fromJson(Map<String, dynamic> json) =>
      CronogramaResponse(
        data: List<CronogramaServer>.from(
            json["data"].map((x) => CronogramaServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
