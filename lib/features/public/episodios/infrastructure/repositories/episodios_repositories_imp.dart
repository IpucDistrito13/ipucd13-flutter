import '../../domain/domains.dart';

class EpisodiosRepositoryImp extends EpisodiosRepository {
  final EpisodiosDatasource datasource;

  EpisodiosRepositoryImp(this.datasource);

  @override
  Future<Episodio> createUpdateEpisodio(Map<String, dynamic> episodioLike) {
    return datasource.createUpdateEpisodio(episodioLike);
  }

  @override
  Future<Episodio> getEpisodioById(String id) {
    return datasource.getEpisodioById(id);
  }

  @override
  Future<List<Episodio>> getEpisodiosByPage(
      {int limit = 10, offset = 0, String apikey = ''}) {
    return datasource.getEpisodiosByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Episodio>> getEpisodiosByPodcast(
      {required String podcastId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getEpisodiosByPodcast(
        podcastId: podcastId, limit: limit, offset: offset);
  }

  @override
  Future<List<Episodio>> searchEpisodiosByTerm(String term) {
    return datasource.searchEpisodiosByTerm(term);
  }
}
