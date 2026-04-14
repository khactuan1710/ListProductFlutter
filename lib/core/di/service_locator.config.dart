// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/auth_local_datasource.dart' as _i929;
import '../../data/datasources/product_api_service.dart' as _i203;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/product_repository_impl.dart' as _i876;
import '../../domain/repositories/auth_repository_interface.dart' as _i907;
import '../../domain/repositories/product_repository_interface.dart' as _i631;
import '../../presentation/cubits/auth/auth_cubit.dart' as _i33;
import '../../presentation/cubits/product_detail/product_detail_cubit.dart'
    as _i359;
import '../../presentation/cubits/product_list/product_list_cubit.dart'
    as _i128;
import '../../presentation/router/guards/auth_guard.dart' as _i72;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i929.AuthLocalDataSource>(
      () => _i929.AuthLocalDataSource(),
    );
    gh.lazySingleton<_i203.ProductApiService>(() => _i203.ProductApiService());
    gh.lazySingleton<_i631.ProductRepository>(
      () => _i876.ProductRepositoryImpl(
        apiService: gh<_i203.ProductApiService>(),
      ),
    );
    gh.factory<_i359.ProductDetailCubit>(
      () => _i359.ProductDetailCubit(repository: gh<_i631.ProductRepository>()),
    );
    gh.factory<_i128.ProductListCubit>(
      () => _i128.ProductListCubit(repository: gh<_i631.ProductRepository>()),
    );
    gh.lazySingleton<_i907.AuthRepository>(
      () => _i895.AuthRepositoryImpl(
        localDataSource: gh<_i929.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i72.AuthGuard>(
      () => _i72.AuthGuard(authRepository: gh<_i907.AuthRepository>()),
    );
    gh.factory<_i33.AuthCubit>(
      () => _i33.AuthCubit(authRepository: gh<_i907.AuthRepository>()),
    );
    return this;
  }
}
