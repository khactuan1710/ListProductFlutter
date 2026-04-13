import 'package:get_it/get_it.dart';

import '../../data/datasources/product_api_service.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository_interface.dart';
import '../../presentation/cubits/product_detail/product_detail_cubit.dart';
import '../../presentation/cubits/product_list/product_list_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  if (getIt.isRegistered<ProductRepository>()) {
    return;
  }

  getIt.registerLazySingleton<ProductApiService>(() => ProductApiService());

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(apiService: getIt<ProductApiService>()),
  );

  getIt.registerFactory<ProductListCubit>(
    () => ProductListCubit(repository: getIt<ProductRepository>()),
  );

  getIt.registerFactory<ProductDetailCubit>(
    () => ProductDetailCubit(repository: getIt<ProductRepository>()),
  );
}
