import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

final videosRepositoryProvider = Provider<VideosRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final videoRepository =
      VideosRepositoriesImp(VideosDatasourceImpl(accessToken: accessToken));

  return videoRepository;
});
