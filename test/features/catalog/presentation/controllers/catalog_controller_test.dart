import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_template/features/catalog/domain/entities/product_entity.dart';
import 'package:my_template/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:my_template/features/catalog/presentation/controllers/catalog_controller.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCatalogRepository mockRepository;
  late CatalogController controller;

  final sampleProducts = [
    const ProductEntity(
      id: '1',
      name: 'MacBook Pro',
      category: 'Electronics',
      price: 1999.99,
      imageUrl: 'https://example.com/1.jpg',
      isFavorite: false,
    ),
    const ProductEntity(
      id: '2',
      name: 'Running Shoes',
      category: 'Fashion',
      price: 120.00,
      imageUrl: 'https://example.com/2.jpg',
      isFavorite: false,
    ),
  ];

  setUp(() {
    mockRepository = MockCatalogRepository();
    when(() => mockRepository.getProducts())
        .thenAnswer((_) async => sampleProducts);

    controller = CatalogController(repository: mockRepository);
  });

  tearDown(() {
    controller.onClose();
  });

  test('clearFilters resets search query, category, text controller, and product grid',
      () async {
    await controller.loadProducts();

    // Set search query and category
    controller.onSearchChanged('MacBook');
    controller.onCategorySelected('Electronics');

    expect(controller.searchQuery, equals('MacBook'));
    expect(controller.searchTextController.text, equals('MacBook'));
    expect(controller.selectedCategory, equals('Electronics'));
    expect(controller.filteredProducts.length, equals(1));

    // Execute clearFilters
    controller.clearFilters();

    expect(controller.searchQuery, isEmpty);
    expect(controller.searchTextController.text, isEmpty);
    expect(controller.selectedCategory, isEmpty);
    expect(controller.filteredProducts.length, equals(2));
  });
}
