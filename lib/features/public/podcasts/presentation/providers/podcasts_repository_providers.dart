import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final podcastsRepositoryProvider = Provider<PodcastsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final podcastRepository = PodcastsRepositoriesImpl(
      PodcastsDatasourceImpl(accessToken: accessToken));

  return podcastRepository;
});