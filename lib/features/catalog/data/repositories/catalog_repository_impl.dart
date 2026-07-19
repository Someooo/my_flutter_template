import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_local_data_source.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  const CatalogRepositoryImpl({required this.dataSource});

  final CatalogLocalDataSource dataSource;

  @override
  Future<List<ProductEntity>> getProducts() async {
    return dataSource.getProducts();
  }
}
