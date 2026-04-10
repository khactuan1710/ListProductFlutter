import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository_interface.dart';
import '../datasources/product_api_service.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService _apiService;

  final Map<int, Product> _cache = {};

  ProductRepositoryImpl({required ProductApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Product>> getProducts({bool forceRefresh = false}) async {
    if (!forceRefresh && _cache.isNotEmpty) {
      return _cache.values.toList()..sort((a, b) => a.id.compareTo(b.id));
    }

    final models = await _apiService.getProducts();
    final products = models.map((m) => m.toEntity()).toList();

    _cache.clear();
    for (final product in products) {
      _cache[product.id] = product;
    }

    return products;
  }

  @override
  Future<Product> getProductById(int id) async {
    if (_cache.containsKey(id)) {
      return _cache[id]!;
    }

    final model = await _apiService.getProductById(id);
    final product = model.toEntity();
    _cache[product.id] = product;
    return product;
  }
}
