import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../presentations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videosRepositoryProvider = Provider<VideosRepository>((ref) {
  //PERMITE REALIZAR PETICIONES A APIS PUBLICAS, EXECPTO
  //REQUIERE TOKEN PARA TURAS PROTEGIDAS
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final videoRepository =
      VideosRepositoriesImp(VideosDatasourceImpl(accessToken: accessToken));

  return videoRepository;
});
