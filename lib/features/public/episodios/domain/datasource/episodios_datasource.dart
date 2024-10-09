import '../domains.dart';

abstract class EpisodiosDatasource {
  Future<List<Episodio>> getEpisodiosByPage(
      {int limit = 10, offset = 0, String apikey = ''});

  Future<Episodio> getEpisodioById(String id);

  Future<List<Episodio>> searchEpisodiosByTerm(String term);

  Future<Episodio> createUpdateEpisodio(Map<String, dynamic> episodioLike);

  Future<List<Episodio>> getEpisodiosByPodcast({
    required String podcastId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });
}
