import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructures.dart';

final episodiosRepositoryProvider = Provider<EpisodiosRepository>((ref) {
  //Permite relizar peticiones a a pis publicas
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final episodioRepository =
      EpisodiosRepositoryImp(EpisodiosDatasourceImpl(accessToken: accessToken));

  return episodioRepository;
});
