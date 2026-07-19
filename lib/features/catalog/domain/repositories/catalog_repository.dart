import '../entities/product_entity.dart';

abstract class CatalogRepository {
  Future<List<ProductEntity>> getProducts();
}
