import '../domains.dart';

abstract class LideresRepository {
  Future<List<Lider>> getLideresByPage({int limit = 10, int offset = 0});

  Future<List<Lider>> getLideresByComite({
    required String comiteId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });

  Future<List<Lider>> searchLiderByTerm(String term);

  Future<List<Lider>> createUpdateLideres(Map<String, dynamic> lideresLike);
}
