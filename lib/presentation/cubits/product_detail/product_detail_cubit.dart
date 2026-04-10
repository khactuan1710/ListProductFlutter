import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/product_repository_interface.dart';
import '../../../data/exceptions/product_api_exception.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository _repository;

  ProductDetailCubit({required ProductRepository repository})
      : _repository = repository,
        super(const ProductDetailInitial());

  Future<void> loadProduct(int id) async {
    emit(const ProductDetailLoading());
    try {
      final product = await _repository.getProductById(id);
      print('call get product by id');
      emit(ProductDetailSuccess(product));
    } on ProductNotFoundException {
      emit(const ProductDetailError('Product not found'));
    } on ProductApiException catch (e) {
      emit(ProductDetailError(e.message));
    } catch (e) {
      emit(ProductDetailError('An unexpected error occurred: $e'));
    }
  }
}
