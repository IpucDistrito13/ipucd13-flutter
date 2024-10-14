import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/insfrastructures.dart';

final carpetaRepositoryProvider = Provider<CarpetasRepository>((ref) {
  //PERMITE REALIZAR PETICIONES A APIS PUBLICAS, EXECPTO
  //REQUIERE TOKEN PARA TURAS PROTEGIDAS
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final carpetaRepository =
      CarpetasRepositoriesImpl(CarpetasDatasourceImp(accessToken: accessToken));

  return carpetaRepository;
});
