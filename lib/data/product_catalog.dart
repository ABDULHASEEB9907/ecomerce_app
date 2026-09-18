import '../models/product.dart';

class ProductCatalog {
  const ProductCatalog._();

  static const Map<String, String> imageFallbacks = {
    'assets/images/logo.jpg':
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=400&q=80',
    'assets/images/feature_shoe.jpg':
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80',
    'assets/images/shoes.jpg':
        'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?auto=format&fit=crop&w=400&q=80',
    'assets/images/clothing.jpg':
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=80',
    'assets/images/watches.jpg':
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=400&q=80',
    'assets/images/electronics.jpg':
        'https://images.unsplash.com/photo-1498049794561-7780e7231661?auto=format&fit=crop&w=400&q=80',
    'assets/images/bags.jpg':
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=400&q=80',
    'assets/images/feature_clothing.jpg':
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
    'assets/images/feature_electronics.jpg':
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80',
    'assets/images/feature_bags.jpg':
        'https://images.unsplash.com/photo-1590874103328-eac38a941956?auto=format&fit=crop&w=600&q=80',
    'assets/images/popular_shoes.jpg':
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80',
    'assets/images/popular_clothing.jpg':
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80',
    'assets/images/popular_bags.jpg':
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=600&q=80',
    'assets/images/popular_watch.jpg':
        'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?auto=format&fit=crop&w=600&q=80',
    'assets/images/iphone.jpg':
        'https://images.unsplash.com/photo-1591337676887-a217a6970a8a?auto=format&fit=crop&w=600&q=80',
    'assets/images/iphone_14.jpg':
        'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?auto=format&fit=crop&w=600&q=80',
  };

  static const List<StoreCategory> categories = [
    StoreCategory(
      name: 'Shoes',
      image: 'assets/images/shoes.jpg',
      imageUrl: 'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?auto=format&fit=crop&w=400&q=80',
    ),
    StoreCategory(
      name: 'Clothing',
      image: 'assets/images/clothing.jpg',
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=80',
    ),
    StoreCategory(
      name: 'Watches',
      image: 'assets/images/watches.jpg',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=400&q=80',
    ),
    StoreCategory(
      name: 'Electronics',
      image: 'assets/images/electronics.jpg',
      imageUrl: 'https://images.unsplash.com/photo-1498049794561-7780e7231661?auto=format&fit=crop&w=400&q=80',
    ),
    StoreCategory(
      name: 'Bags',
      image: 'assets/images/bags.jpg',
      imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  static const List<Product> products = [
    Product(
      name: 'Nike Air Force 1',
      category: 'Shoes',
      price: 'Rs. 24,999',
      rating: '4.8',
      reviews: '(120)',
      image: 'assets/images/feature_shoe.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80',
      featured: true,
      keywords: ['nike', 'air force', 'sneakers', 'shoe'],
    ),
    Product(
      name: 'Royal Smart Watch',
      category: 'Watches',
      price: 'Rs. 7,999',
      rating: '4.7',
      reviews: '(89)',
      image: 'assets/images/feature_clothing.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
      featured: true,
      keywords: ['watch', 'smartwatch', 'royal'],
    ),
    Product(
      name: 'Studio Pro Headset',
      category: 'Electronics',
      price: 'Rs. 14,699',
      rating: '4.9',
      reviews: '(156)',
      image: 'assets/images/feature_electronics.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80',
      featured: true,
      keywords: ['headset', 'headphones', 'audio'],
    ),
    Product(
      name: 'Michael Kors Leather',
      category: 'Bags',
      price: 'Rs. 45,999',
      rating: '4.8',
      reviews: '(76)',
      image: 'assets/images/feature_bags.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1590874103328-eac38a941956?auto=format&fit=crop&w=600&q=80',
      featured: true,
      keywords: ['bag', 'handbag', 'leather', 'michael kors'],
    ),
    Product(
      name: 'Nike Running Shoes',
      category: 'Shoes',
      price: 'Rs. 22,999',
      rating: '4.7',
      reviews: '(94)',
      image: 'assets/images/popular_shoes.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80',
      popular: true,
      keywords: ['nike', 'running', 'sneakers', 'shoe'],
    ),
    Product(
      name: 'Polo T-Shirt',
      category: 'Clothing',
      price: 'Rs. 6,999',
      rating: '4.6',
      reviews: '(81)',
      image: 'assets/images/popular_clothing.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=80',
      popular: true,
      keywords: ['shirt', 'tshirt', 'polo', 'clothes'],
    ),
    Product(
      name: 'Travel Backpack',
      category: 'Bags',
      price: 'Rs. 12,999',
      rating: '4.8',
      reviews: '(64)',
      image: 'assets/images/popular_bags.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=600&q=80',
      popular: true,
      keywords: ['bag', 'backpack', 'travel'],
    ),
    Product(
      name: 'Apple Pro',
      category: 'Watches',
      price: 'Rs. 48,999',
      rating: '4.9',
      reviews: '(120)',
      image: 'assets/images/popular_watch.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?auto=format&fit=crop&w=600&q=80',
      popular: true,
      keywords: ['watch', 'apple', 'smartwatch', 'apple watch'],
    ),
    Product(
      name: 'iPhone 15 Pro',
      category: 'Electronics',
      price: 'Rs. 389,999',
      rating: '4.9',
      reviews: '(210)',
      image: 'assets/images/iphone.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1591337676887-a217a6970a8a?auto=format&fit=crop&w=600&q=80',
      popular: true,
      keywords: ['iphone', 'apple', 'phone', 'mobile'],
    ),
    Product(
      name: 'iPhone 14',
      category: 'Electronics',
      price: 'Rs. 259,999',
      rating: '4.8',
      reviews: '(178)',
      image: 'assets/images/iphone_14.jpg',
      imageUrl:
          'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?auto=format&fit=crop&w=600&q=80',
      keywords: ['iphone', 'apple', 'phone', 'mobile'],
    ),
  ];

  static List<Product> get featured =>
      products.where((product) => product.featured).toList();

  static List<Product> get popular =>
      products.where((product) => product.popular).toList();

  static List<Product> search(String query) {
    return products.where((product) => product.matches(query)).toList();
  }

  static String? fallbackFor(String path) => imageFallbacks[path];
}
