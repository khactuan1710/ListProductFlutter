import '../entities/product.dart';


abstract class ProductRepository {

  Future<List<Product>> getProducts({bool forceRefresh = false});


  Future<Product> getProductById(int id);
}
