// To parse this JSON data, do
//
//     final sliderResponse = sliderResponseFromJson(jsonString);

import 'dart:convert';

import '../infrastructure.dart';

SliderResponse sliderResponseFromJson(String str) =>
    SliderResponse.fromJson(json.decode(str));

String sliderResponseToJson(SliderResponse data) => json.encode(data.toJson());

class SliderResponse {
  final List<SliderServer> data;

  SliderResponse({
    required this.data,
  });

  factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
        data: List<SliderServer>.from(
            json["data"].map((x) => SliderServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
