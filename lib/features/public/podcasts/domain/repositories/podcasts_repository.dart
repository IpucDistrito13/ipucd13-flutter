import '/features/public/podcasts/domain/domains.dart';

abstract class PodcastsRepository {
  Future<List<Podcast>> getPodcastsByPage(
      {int limit = 10, int offset = 0, String apikey = ''});

  Future<Podcast> getPodcastById(String id);

  Future<List<Podcast>> searchPodcastByTerm(String term);

  Future<Podcast> createUpdatePodcast(Map<String, dynamic> podcastLike);

  Future<List<Podcast>> getPodcastByComite({
    required String comiteId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });
}
