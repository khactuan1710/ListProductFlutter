import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import '../exceptions/product_api_exception.dart';
import 'logger/logging_client.dart';

class ProductApiService {
  static const _baseUrl = 'https://dummyjson.com';
  static const _timeout = Duration(seconds: 10);

  final http.Client _client;

  ProductApiService({http.Client? client})
    : _client = client ?? LoggingClient(http.Client());

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/products'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        try {
          final decoded = json.decode(response.body);
          if (decoded is! Map<String, dynamic>) {
            throw const FormatException(
              'Expected object response for products',
            );
          }

          final jsonList = decoded['products'];
          if (jsonList is! List) {
            throw const FormatException("Missing or invalid 'products' list");
          }

          return jsonList
              .map(
                (json) => ProductModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        } on FormatException catch (e) {
          print('❌ Parse error (getProducts): $e');
          throw ProductApiException.parseError();
        }
      } else {
        print('❌ HTTP error (getProducts): ${response.statusCode}');
        print('👉 Body: ${response.body}');
        throw ProductApiException.httpError(response.statusCode);
      }
    } on TimeoutException catch (e) {
      print('❌ Timeout (getProducts): $e');
      throw ProductApiException.networkError('Request timed out');
    } on http.ClientException catch (e) {
      print('❌ Client error (getProducts): ${e.message}');
      throw ProductApiException.networkError(e.message);
    } catch (e, stackTrace) {
      print('❌ Unknown error (getProducts): $e');
      print(stackTrace);
      rethrow;
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _client
          .get(Uri.parse('$_baseUrl/products/$id'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          if (json == null) {
            print('❌ Product null with id: $id');
            throw ProductNotFoundException(id);
          }
          print('get product by id success');
          return ProductModel.fromJson(json as Map<String, dynamic>);
        } on FormatException catch (e) {
          print('❌ Parse error (getProductById): $e');
          throw ProductApiException.parseError();
        }
      } else {
        print('❌ HTTP error (getProductById): ${response.statusCode}');
        print('👉 Body: ${response.body}');
        throw ProductApiException.httpErrorSingleProduct(response.statusCode);
      }
    } on TimeoutException catch (e) {
      print('❌ Timeout (getProductById): $e');
      throw ProductApiException.networkError('Request timed out');
    } on http.ClientException catch (e) {
      print('❌ Client error (getProductById): ${e.message}');
      throw ProductApiException.networkError(e.message);
    } catch (e, stackTrace) {
      print('❌ Unknown error (getProductById): $e');
      print(stackTrace);
      rethrow;
    }
  }

  void dispose() {
    _client.close();
  }
}
