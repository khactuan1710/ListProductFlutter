/// Base exception for API-level errors in the product data layer.
class ProductApiException implements Exception {
  final String message;
  final int? statusCode;

  const ProductApiException(this.message, {this.statusCode});

  @override
  String toString() => message;

  factory ProductApiException.httpError(int statusCode) {
    return ProductApiException(
      'Failed to load products: $statusCode',
      statusCode: statusCode,
    );
  }

  factory ProductApiException.httpErrorSingleProduct(int statusCode) {
    if (statusCode == 404) {
      return const ProductApiException('Product not found', statusCode: 404);
    }
    return ProductApiException(
      'Failed to load product: $statusCode',
      statusCode: statusCode,
    );
  }

  factory ProductApiException.networkError(String reason) {
    return ProductApiException('Network error: $reason');
  }

  factory ProductApiException.parseError() {
    return const ProductApiException('Failed to parse product data');
  }
}

class ProductNotFoundException implements Exception {
  final int productId;

  const ProductNotFoundException(this.productId);

  @override
  String toString() => 'Product with id $productId not found';
}
