// Response de detalles para <Lista>
import 'dart:convert';

import '../infrastructure.dart';

PodcastDetailsResponse podcastDetailsResponseFromJson(String str) =>
    PodcastDetailsResponse.fromJson(json.decode(str));

String podcastDetailsResponseToJson(PodcastDetailsResponse data) =>
    json.encode(data.toJson());

class PodcastDetailsResponse {
  final PodcastDetailsServer data;

  PodcastDetailsResponse({
    required this.data,
  });

  factory PodcastDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PodcastDetailsResponse(
        data: PodcastDetailsServer.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
