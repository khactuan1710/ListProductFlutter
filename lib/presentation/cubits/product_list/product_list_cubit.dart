import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repositories/product_repository_interface.dart';
import '../../../data/exceptions/product_api_exception.dart';
import 'product_list_state.dart';

@injectable
class ProductListCubit extends Cubit<ProductListState> {
  final ProductRepository _repository;

  ProductListCubit({required ProductRepository repository})
      : _repository = repository,
        super(const ProductListInitial());

  Future<void> loadProducts() async {
    emit(const ProductListLoading());
    await _fetchProducts(forceRefresh: false);
  }

  Future<void> refreshProducts() async {
    await _fetchProducts(forceRefresh: true);
  }

  Future<void> retry() async {
    emit(const ProductListLoading());
    await _fetchProducts(forceRefresh: false);
  }

  Future<void> _fetchProducts({required bool forceRefresh}) async {
    try {
      final products =
          await _repository.getProducts(forceRefresh: forceRefresh);
      emit(ProductListSuccess(products));
    } on ProductApiException catch (e) {
      emit(ProductListError(e.message));
    } catch (e) {
      emit(ProductListError('An unexpected error occurred: $e'));
    }
  }
}
