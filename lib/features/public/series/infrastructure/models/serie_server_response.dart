import '../infrastructure.dart';

class SeriesServerResponse {
  final List<SerieServer> data;

  SeriesServerResponse({
    required this.data,
  });

  factory SeriesServerResponse.fromJson(Map<String, dynamic> json) =>
      SeriesServerResponse(
        data: List<SerieServer>.from(
            json["data"].map((x) => SerieServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
