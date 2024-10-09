import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructures.dart';

final archivoRepositoryProvider = Provider<ArchivosRepository>((ref) {
  //Permite relizar peticiones a apis publicas
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final archivoRepository = ArchivosRepositoriesImpl(
      ArchivosDatasourceImpl(accessToken: accessToken));

  return archivoRepository;
});
