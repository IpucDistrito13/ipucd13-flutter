import '../../domain/domains.dart';

class PodcastsRepositoriesImpl extends PodcastsRepository {
  final PodcastsDatasource datasource;

  PodcastsRepositoriesImpl(this.datasource);

  @override
  Future<Podcast> createUpdatePodcast(Map<String, dynamic> podcastLike) {
    return datasource.createUpdatePodcast(podcastLike);
  }

  @override
  Future<Podcast> getPodcastById(String id) {
    return datasource.getPodcastById(id);
  }

  @override
  Future<List<Podcast>> getPodcastsByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) {
    return datasource.getPodcastsByPage(
        limit: limit, offset: offset, apikey: apikey);
  }

  @override
  Future<List<Podcast>> searchPodcastByTerm(String term) {
    return datasource.searchPodcastByTerm(term);
  }

  @override
  Future<List<Podcast>> getPodcastByComite(
      {required String comiteId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getPodcastByComite(comiteId: comiteId);
  }
}
