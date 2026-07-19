import 'dart:math';

import '../models/product_model.dart';

abstract class CatalogLocalDataSource {
  Future<List<ProductModel>> getProducts();
}

class CatalogLocalDataSourceImpl implements CatalogLocalDataSource {
  List<ProductModel>? _cache;

  @override
  Future<List<ProductModel>> getProducts() async {
    _cache ??= _generateProducts();
    return _cache!;
  }

  List<ProductModel> _generateProducts() {
    final random = Random(42);
    final products = <ProductModel>[];
    int id = 1;

    for (final category in _categories) {
      final names = _namesByCategory[category]!;
      final range = _priceRangeByCategory[category]!;
      final count = _countByCategory[category]!;

      for (int i = 0; i < count; i++) {
        final name = names[i % names.length];
        final variant = (i ~/ names.length) + 1;
        final displayName = variant > 1 ? '$name $variant' : name;

        final price = _randomPrice(random, range[0], range[1]);
        final imageUrl = _stableImageUrl(id);

        products.add(ProductModel(
          id: 'product_$id',
          name: displayName,
          category: category,
          price: price,
          imageUrl: imageUrl,
          isFavorite: false,
        ));

        id++;
      }
    }

    return products;
  }

  double _randomPrice(Random random, double min, double max) {
    final raw = min + random.nextDouble() * (max - min);
    return double.parse(raw.toStringAsFixed(2));
  }

  String _stableImageUrl(int productId) {
    return 'https://picsum.photos/seed/$productId/400/400';
  }
}

const List<String> _categories = [
  'Electronics',
  'Fashion',
  'Home',
  'Sports',
  'Books',
  'Food',
  'Beauty',
  'Toys',
];

const Map<String, int> _countByCategory = {
  'Electronics': 320,
  'Fashion': 320,
  'Home': 280,
  'Sports': 280,
  'Books': 250,
  'Food': 200,
  'Beauty': 200,
  'Toys': 150,
};

const Map<String, List<double>> _priceRangeByCategory = {
  'Electronics': [150.0, 2500.0],
  'Fashion': [25.0, 400.0],
  'Home': [15.0, 900.0],
  'Sports': [20.0, 500.0],
  'Books': [10.0, 60.0],
  'Food': [2.0, 80.0],
  'Beauty': [8.0, 250.0],
  'Toys': [5.0, 150.0],
};

const Map<String, List<String>> _namesByCategory = {
  'Electronics': [
    'MacBook Air',
    'MacBook Pro',
    'iPhone 16',
    'iPhone 15 Pro',
    'iPad Pro',
    'iPad Air',
    'Samsung Galaxy S24',
    'Samsung Galaxy Tab',
    'Samsung 4K TV',
    'Sony Bravia TV',
    'LG OLED TV',
    'Dell XPS Laptop',
    'HP Spectre Laptop',
    'Lenovo ThinkPad',
    'Microsoft Surface Pro',
    'Google Pixel 9',
    'OnePlus 12',
    'Sony WH-1000XM5 Headphones',
    'AirPods Pro',
    'Bose QuietComfort Headphones',
    'Logitech MX Master Mouse',
    'Mechanical Keyboard',
    'Apple Watch Series 9',
    'Samsung Galaxy Watch',
    'GoPro Hero 12',
    'DJI Mini Drone',
    'Nintendo Switch',
    'PlayStation 5',
    'Xbox Series X',
    'Portable SSD 1TB',
    'USB-C Hub',
    'Smart Home Speaker',
  ],
  'Fashion': [
    'Nike Running Shoes',
    'Adidas Ultraboost',
    'Levi\'s Slim Jeans',
    'Cotton Polo Shirt',
    'Wool Blazer',
    'Leather Jacket',
    'Summer Dress',
    'Floral Blouse',
    'Skinny Chinos',
    'Cashmere Sweater',
    'Puffer Jacket',
    'Denim Shorts',
    'Silk Scarf',
    'Leather Handbag',
    'Canvas Backpack',
    'Running Shorts',
    'Yoga Pants',
    'Sports Bra',
    'Athletic Hoodie',
    'Classic Sneakers',
    'Sandals',
    'Ankle Boots',
    'Chelsea Boots',
    'Flat Cap',
    'Baseball Cap',
    'Sunglasses',
    'Woven Belt',
    'Knit Beanie',
    'Trench Coat',
    'Slim-Fit Suit',
  ],
  'Home': [
    'Coffee Table',
    'Desk Lamp',
    'Office Chair',
    'Standing Desk',
    'Bookshelf',
    'Sofa Cushion Set',
    'Area Rug',
    'Blackout Curtains',
    'Wooden Picture Frame',
    'Scented Candle Set',
    'Bamboo Cutting Board',
    'Cast Iron Skillet',
    'French Press Coffee Maker',
    'Espresso Machine',
    'Air Fryer',
    'Blender',
    'Rice Cooker',
    'Toaster Oven',
    'Robot Vacuum',
    'Air Purifier',
    'Ceramic Dinnerware Set',
    'Glass Storage Containers',
    'Throw Blanket',
    'Memory Foam Pillow',
    'Bath Towel Set',
    'Shower Caddy',
    'Plant Pot Set',
    'LED Strip Lights',
    'Smart Plug',
    'Wall Clock',
  ],
  'Sports': [
    'Nike Running Shoes',
    'Yoga Mat',
    'Football',
    'Basketball',
    'Tennis Racket',
    'Badminton Set',
    'Resistance Bands',
    'Dumbbells Set',
    'Pull-Up Bar',
    'Jump Rope',
    'Cycling Helmet',
    'Road Bike',
    'Mountain Bike',
    'Swim Goggles',
    'Kickboard',
    'Soccer Cleats',
    'Boxing Gloves',
    'Punching Bag',
    'Foam Roller',
    'Protein Shaker Bottle',
    'Gym Bag',
    'Fitness Tracker Band',
    'Treadmill',
    'Rowing Machine',
    'Adjustable Bench',
    'Kettlebell',
    'Ankle Weights',
    'Balance Board',
    'Hiking Backpack',
    'Trekking Poles',
  ],
  'Books': [
    'Flutter in Action',
    'Clean Code',
    'Atomic Habits',
    'Deep Work',
    'The Pragmatic Programmer',
    'Design Patterns',
    'Refactoring',
    'Domain-Driven Design',
    'The Clean Coder',
    'Code Complete',
    'Introduction to Algorithms',
    'The Art of Computer Programming',
    'Eloquent JavaScript',
    'Python Crash Course',
    'Kotlin in Action',
    'Swift Programming',
    'The Lean Startup',
    'Zero to One',
    'Good to Great',
    'Sapiens',
    'Thinking Fast and Slow',
    'The Psychology of Money',
    'Rich Dad Poor Dad',
    'The Subtle Art',
    'Man\'s Search for Meaning',
    'To Kill a Mockingbird',
    '1984',
    'The Great Gatsby',
    'Dune',
    'The Hitchhiker\'s Guide',
  ],
  'Food': [
    'Organic Honey Jar',
    'Extra Virgin Olive Oil',
    'Dark Roast Coffee Beans',
    'Green Tea Collection',
    'Himalayan Pink Salt',
    'Organic Coconut Oil',
    'Almond Butter',
    'Dark Chocolate Bar',
    'Mixed Nuts Pack',
    'Dried Fruit Mix',
    'Protein Granola',
    'Oat Milk Pack',
    'Sparkling Water Case',
    'Herbal Tea Set',
    'Quinoa Pack',
    'Chia Seeds',
    'Flaxseed Powder',
    'Apple Cider Vinegar',
    'Balsamic Vinegar',
    'Artisan Hot Sauce',
  ],
  'Beauty': [
    'Vitamin C Serum',
    'Hyaluronic Acid Moisturizer',
    'Retinol Night Cream',
    'SPF 50 Sunscreen',
    'Micellar Cleansing Water',
    'Face Sheet Mask Set',
    'Eye Cream',
    'Lip Balm Set',
    'BB Cream',
    'Foundation',
    'Mascara',
    'Eyeliner',
    'Eyeshadow Palette',
    'Blush Palette',
    'Highlighter',
    'Setting Spray',
    'Makeup Remover Wipes',
    'Shampoo',
    'Conditioner',
    'Hair Serum',
    'Dry Shampoo',
    'Perfume',
    'Body Lotion',
    'Shower Gel',
    'Bath Salts',
    'Face Roller',
    'Gua Sha Stone',
    'Electric Face Cleanser',
    'Nail Polish Set',
    'Cuticle Oil',
  ],
  'Toys': [
    'LEGO City Set',
    'LEGO Technic',
    'Barbie Doll',
    'Hot Wheels Set',
    'Remote Control Car',
    'Jigsaw Puzzle 1000pc',
    'Board Game',
    'Chess Set',
    'Rubik\'s Cube',
    'Play-Doh Set',
    'Art Supply Kit',
    'Science Experiment Kit',
    'Telescope for Kids',
    'Microscope Kit',
    'Magnetic Building Tiles',
    'Wooden Train Set',
    'Stuffed Animal',
    'Action Figure',
    'Nerf Blaster',
    'Card Game',
  ],
};
