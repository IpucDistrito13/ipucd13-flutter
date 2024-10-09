import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/presentation/providers/auth_provider.dart';
import '/features/products/domain/domain.dart';
import '/features/products/infrastructure/datasources/products_datasource_impl.dart';
import '/features/products/infrastructure/repositories/products_repository_impl.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository =
      ProductsRepositoryImpl(ProductsDatasourceImpl(accessToken: accessToken));

  return productsRepository;
});
