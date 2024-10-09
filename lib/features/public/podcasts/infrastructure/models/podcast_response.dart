import 'dart:convert';

import '/features/public/podcasts/infrastructure/infrastructure.dart';

PodcastResponse PodcastResponseFromJson(String str) =>
    PodcastResponse.fromJson(json.decode(str));

String PodcastResponseToJson(PodcastResponse data) =>
    json.encode(data.toJson());

class PodcastResponse {
  final List<PodcastServer> data;

  PodcastResponse({
    required this.data,
  });

  factory PodcastResponse.fromJson(Map<String, dynamic> json) =>
      PodcastResponse(
        data: List<PodcastServer>.from(
            json["data"].map((x) => PodcastServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
