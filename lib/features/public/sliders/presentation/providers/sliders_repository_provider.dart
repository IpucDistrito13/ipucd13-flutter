import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final slidersRepositoryProvider = Provider<SlidersRepository>((ref) {
  //Al ser watch, cuando el authProvider cambie si se logueo usuario se deslogueo
  //atambien actualiza todo lo que hay

  //Cuando un usuario se desloguea continua con token vacio
  //los endponts publicos continua funcionado execto los protegidos
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final slidersRepository =
      SlidersRepositoryImpl(SlidersDatasourceImpl(accessToken: accessToken));

  return slidersRepository;
});
