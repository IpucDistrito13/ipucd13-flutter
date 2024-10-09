// To parse this JSON data, do
//
//     final eventoResponse = eventoResponseFromJson(jsonString);

import 'dart:convert';

import '/features/public/eventos/infrastructure/infrastructure.dart';

EventoResponse eventoResponseFromJson(String str) =>
    EventoResponse.fromJson(json.decode(str));

String eventoResponseToJson(EventoResponse data) => json.encode(data.toJson());

class EventoResponse {
  final List<EventoServer> data;

  EventoResponse({
    required this.data,
  });

  factory EventoResponse.fromJson(Map<String, dynamic> json) => EventoResponse(
        data: List<EventoServer>.from(
            json["data"].map((x) => EventoServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
