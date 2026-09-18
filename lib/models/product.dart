class Product {
  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.image,
    this.imageUrl,
    this.featured = false,
    this.popular = false,
    this.keywords = const [],
  });

  final String name;
  final String category;
  final String price;
  final String rating;
  final String reviews;
  final String image;
  final String? imageUrl;
  final bool featured;
  final bool popular;
  final List<String> keywords;

  bool matches(String rawQuery) {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) return false;

    final haystack = <String>[
      name,
      category,
      ...keywords,
    ].map((value) => value.toLowerCase()).join(' ');

    return haystack.contains(query);
  }
}

class StoreCategory {
  const StoreCategory({
    required this.name,
    required this.image,
    this.imageUrl,
  });

  final String name;
  final String image;
  final String? imageUrl;
}
