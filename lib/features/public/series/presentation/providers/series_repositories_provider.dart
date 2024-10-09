import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final seriesRepositoryProvider = Provider<SeriesRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final serieRepository =
      SeriesRepositoriesImp(SeriesDatasourceImpl(accessToken: accessToken));

  return serieRepository;
});