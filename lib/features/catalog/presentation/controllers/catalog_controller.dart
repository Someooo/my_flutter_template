import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/catalog_repository.dart';

class CatalogController extends GetxController {
  CatalogController({required CatalogRepository repository})
      : _repository = repository;

  final CatalogRepository _repository;

  List<ProductEntity> _allProducts = [];
  final RxList<ProductEntity> _filteredProducts = <ProductEntity>[].obs;
  final RxString _selectedCategory = ''.obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;
  final Rxn<String> _errorMessage = Rxn<String>();
  Timer? _debounceTimer;
  final Map<String, RxBool> _favoriteRxMap = {};
  final RxInt _favoriteCount = 0.obs;
  final RxDouble _favoriteTotalPrice = 0.0.obs;

  final TextEditingController searchTextController = TextEditingController();

  List<ProductEntity> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  bool get hasError => _errorMessage.value != null;
  bool get isEmpty => !_isLoading.value && _filteredProducts.isEmpty;

  bool isFavorite(String productId) =>
      _favoriteRxMap[productId]?.value ?? false;

  List<String> get categories => _cachedCategories;
  List<String> _cachedCategories = [];

  int get favoriteCount => _favoriteCount.value;
  double get favoriteTotalPrice => _favoriteTotalPrice.value;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchTextController.dispose();
    super.onClose();
  }

  Future<void> loadProducts() async {
    _isLoading.value = true;
    _errorMessage.value = null;

    try {
      _allProducts = await _repository.getProducts();

      var count = 0;
      var total = 0.0;
      final entries = <MapEntry<String, RxBool>>[];
      for (final p in _allProducts) {
        entries.add(MapEntry(p.id, p.isFavorite.obs));
        if (p.isFavorite) {
          count++;
          total += p.price;
        }
      }
      _favoriteRxMap
        ..clear()
        ..addEntries(entries);
      _favoriteCount.value = count;
      _favoriteTotalPrice.value = total;

      _cachedCategories = _buildCategories();
      _applyFilters();
    } catch (e) {
      _errorMessage.value = 'Failed to load products. Please try again.';
    } finally {
      _isLoading.value = false;
    }
  }

  void onSearchChanged(String query) {
    _searchQuery.value = query;
    if (searchTextController.text != query) {
      searchTextController.value = TextEditingValue(
        text: query,
        selection: TextSelection.collapsed(offset: query.length),
      );
    }
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_kDebounceDelay, _applyFilters);
  }

  static const Duration _kDebounceDelay = Duration(milliseconds: 300);

  void onCategorySelected(String category) {
    _selectedCategory.value = category;
    _applyFilters();
  }

  void clearFilters() {
    _debounceTimer?.cancel();
    searchTextController.clear();
    _searchQuery.value = '';
    _selectedCategory.value = '';
    _applyFilters();
    FocusManager.instance.primaryFocus?.unfocus();
  }


  void toggleFavorite(String productId) {
    final index = _allProducts.indexWhere((p) => p.id == productId);
    if (index == -1) return;

    final current = _allProducts[index];
    final newFavorite = !current.isFavorite;

    _allProducts[index] = ProductModel(
      id: current.id,
      name: current.name,
      category: current.category,
      price: current.price,
      imageUrl: current.imageUrl,
      isFavorite: newFavorite,
    );

    _favoriteRxMap[productId]?.value = newFavorite;

    if (newFavorite) {
      _favoriteCount.value++;
      _favoriteTotalPrice.value += current.price;
    } else {
      _favoriteCount.value--;
      _favoriteTotalPrice.value -= current.price;
    }
  }

  void _applyFilters() {
    final category = _selectedCategory.value;
    final query = _searchQuery.value.trim().toLowerCase();

    final List<ProductEntity> result;

    if (category.isNotEmpty && query.isNotEmpty) {
      result = _allProducts
          .where(
            (p) =>
                p.category == category && p.name.toLowerCase().contains(query),
          )
          .toList();
    } else if (category.isNotEmpty) {
      result = _allProducts.where((p) => p.category == category).toList();
    } else if (query.isNotEmpty) {
      result = _allProducts
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
    } else {
      result = _allProducts;
    }

    _filteredProducts.assignAll(result);
  }

  List<String> _buildCategories() {
    final seen = <String>{};
    final result = <String>[];
    for (final product in _allProducts) {
      if (seen.add(product.category)) {
        result.add(product.category);
      }
    }
    result.sort();
    return result;
  }
}
