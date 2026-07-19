import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        price,
        imageUrl,
        isFavorite,
      ];
}
