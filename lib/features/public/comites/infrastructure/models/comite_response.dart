import '../infrastructure.dart';

class ComitesServerResponse {
  final List<ComitesServer> data;

  ComitesServerResponse({
    required this.data,
  });

  factory ComitesServerResponse.fromJson(Map<String, dynamic> json) =>
      ComitesServerResponse(
        data: List<ComitesServer>.from(
            json["data"].map((x) => ComitesServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
