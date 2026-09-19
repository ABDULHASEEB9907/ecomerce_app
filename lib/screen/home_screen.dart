import 'package:flutter/material.dart';

import '../data/product_catalog.dart';
import '../models/product.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Category filter
  String? _selectedCategory;

  // ============================================================
  // AH STORE THEME
  // ============================================================

  static const Color background = Color(0xFF080705);
  static const Color card = Color(0xFF11100D);
  static const Color imageBackground = Color(0xFF171613);
  static const Color border = Color(0xFF3D3728);

  static const Color gold = Color(0xFFC5A33D);
  static const Color lightGold = Color(0xFFD2B24C);

  static const Color white = Color(0xFFF5F2EA);
  static const Color grey = Color(0xFF8D8981);

  String get _searchQuery => searchController.text.trim();

  bool get _isSearching => _searchQuery.isNotEmpty;

  bool get _isFilteringCategory =>
      _selectedCategory != null && !_isSearching;

  List<Product> get _searchResults => ProductCatalog.search(_searchQuery);

  List<Product> get _categoryResults {
    final category = _selectedCategory;
    if (category == null || category.isEmpty) return [];

    return ProductCatalog.products
        .where(
          (product) =>
              product.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _applySearch(String value) {
    _selectedCategory = null;

    searchController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    setState(() {});
  }

  void _clearSearch() {
    searchController.clear();
    _selectedCategory = null;
    searchFocusNode.unfocus();
    setState(() {});
  }

  void _applyCategoryFilter(String category) {
    searchController.clear();
    searchFocusNode.unfocus();

    setState(() {
      _selectedCategory = category;
      selectedIndex = 0;
    });
  }

  void _clearCategoryFilter() {
    setState(() {
      _selectedCategory = null;
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            // Mobile style width.
            // Desktop/browser par bhi layout unnecessarily stretch nahi hoga.
            final double contentWidth =
                screenWidth > 430 ? 430 : screenWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    // ==================================================
                    // HEADER
                    // ==================================================

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          14,
                          12,
                          14,
                          0,
                        ),
                        child: Row(
                          children: [
                            // LOGO
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFF11151D),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: border,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: _safeImage(
                                  'assets/images/logo.jpg',
                                  fit: BoxFit.contain,
                                  iconSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(width: 9),

                            // TEXT
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AH STORE',
                                  style: TextStyle(
                                    color: lightGold,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Hello, Shopper 👋',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            _circleButton(
                              Icons.notifications_none_rounded,
                            ),

                            const SizedBox(width: 7),

                            _circleButton(
                              Icons.person_outline_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SUBTITLE
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          14,
                          5,
                          14,
                          0,
                        ),
                        child: Text(
                          'What are you looking for today?',
                          style: TextStyle(
                            color: grey,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),

                    // ==================================================
                    // SEARCH
                    // ==================================================

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          14,
                          10,
                          14,
                          0,
                        ),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF11151D),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF30343A),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 11),

                              const Icon(
                                Icons.search_rounded,
                                color: Color(0xFF9A958C),
                                size: 17,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  focusNode: searchFocusNode,
                                  onChanged: (_) => setState(() {}),
                                  cursorColor: gold,
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: 9,
                                  ),
                                  textInputAction: TextInputAction.search,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: 'Search products...',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF77736C),
                                      fontSize: 9,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),

                              if (_isSearching)
                                GestureDetector(
                                  onTap: _clearSearch,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Color(0xFF9A958C),
                                      size: 16,
                                    ),
                                  ),
                                )
                              else
                                const Icon(
                                  Icons.tune_rounded,
                                  color: lightGold,
                                  size: 16,
                                ),

                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),

                    if (_isSearching)
                      ..._searchSlivers()
                    else if (_isFilteringCategory)
                      ..._categoryFilterSlivers()
                    else
                      ..._homeSlivers(),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // ============================================================
      // BOTTOM NAVIGATION
      // ============================================================

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 68,
          decoration: const BoxDecoration(
            color: Color(0xFF080B0E),
            border: Border(
              top: BorderSide(
                color: Color(0xFF25272A),
                width: 0.7,
              ),
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 430,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _bottomNav(
                    Icons.home_rounded,
                    'Home',
                    0,
                  ),
                  _bottomNav(
                    Icons.grid_view_rounded,
                    'Categories',
                    1,
                  ),
                  _bottomNav(
                    Icons.shopping_cart_outlined,
                    'Cart',
                    2,
                  ),
                  _bottomNav(
                    Icons.receipt_long_outlined,
                    'Orders',
                    3,
                  ),
                  _bottomNav(
                    Icons.person_outline_rounded,
                    'Profile',
                    4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _homeSlivers() {
    final categories = ProductCatalog.categories;
    final featured = ProductCatalog.featured;
    final popular = ProductCatalog.popular;

    return [
      // ==================================================
      // HERO BANNER
      // ==================================================

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            14,
            11,
            14,
            0,
          ),
          child: SizedBox(
            height: 112,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFF11100D),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF665326),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // PRODUCT IMAGE
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 170,
                    child: _safeImage(
                      'assets/images/feature_shoe.jpg',
                      fit: BoxFit.cover,
                      iconSize: 26,
                    ),
                  ),

                  // DARK GRADIENT
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [
                            0.0,
                            0.48,
                            0.72,
                            1.0,
                          ],
                          colors: [
                            Color(0xFF11100D),
                            Color(0xFF11100D),
                            Color(0x5511100D),
                            Color(0x0011100D),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // TEXT
                  Positioned(
                    left: 12,
                    top: 10,
                    right: 145,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF1B1A15,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(
                                0xFF665326,
                              ),
                            ),
                          ),
                          child: const Text(
                            'LIMITED EDITION',
                            style: TextStyle(
                              color: lightGold,
                              fontSize: 6.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Discover',
                          maxLines: 1,
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const Text(
                          'Your Style',
                          maxLines: 1,
                          style: TextStyle(
                            color: lightGold,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          'Premium products at great prices',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: grey,
                            fontSize: 7,
                          ),
                        ),

                        const SizedBox(height: 7),

                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () => _applySearch('shoes'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: gold,
                              foregroundColor: background,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Shop Now  →',
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ==================================================
      // BANNER DOTS
      // ==================================================

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(true),
              const SizedBox(width: 4),
              _dot(false),
              const SizedBox(width: 4),
              _dot(false),
              const SizedBox(width: 4),
              _dot(false),
            ],
          ),
        ),
      ),

      // ==================================================
      // CATEGORIES
      // ==================================================

      SliverToBoxAdapter(
        child: _sectionTitle(
          'Categories',
          'See All  →',
          onAction: () async {
            final String? category = await Navigator.push<String>(
              context,
              MaterialPageRoute(
                builder: (_) => const CategoryScreen(),
              ),
            );
            if (category != null && category.isNotEmpty) {
              _applyCategoryFilter(category);
            }
          },
        ),
      ),

      SliverToBoxAdapter(
        child: SizedBox(
          height: 84,
          child: categories.isEmpty
              ? const Center(
                  child: Text(
                    'No categories available',
                    style: TextStyle(
                      color: grey,
                      fontSize: 8,
                    ),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => _space(),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return _category(
                      category.image,
                      category.name,
                      imageUrl: category.imageUrl,
                    );
                  },
                ),
        ),
      ),

      // ==================================================
      // FEATURED PRODUCTS
      // ==================================================

      SliverToBoxAdapter(
        child: _sectionTitle(
          'Featured Products',
          'See All  →',
        ),
      ),

      SliverToBoxAdapter(
        child: SizedBox(
          height: 168,
          child: featured.isEmpty
              ? const Center(
                  child: Text(
                    'No featured products yet',
                    style: TextStyle(
                      color: grey,
                      fontSize: 8,
                    ),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 2,
                  ),
                  itemCount: featured.length,
                  separatorBuilder: (_, __) => _featuredSpace(),
                  itemBuilder: (context, index) {
                    return _featured(featured[index]);
                  },
                ),
        ),
      ),

      // ==================================================
      // POPULAR
      // ==================================================

      SliverToBoxAdapter(
        child: _sectionTitle(
          'Popular Products',
          'See All  →',
        ),
      ),

      if (popular.isEmpty)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(14, 8, 14, 24),
            child: Text(
              'No popular products yet',
              style: TextStyle(
                color: grey,
                fontSize: 8,
              ),
            ),
          ),
        )
      else
        _productGrid(popular),
    ];
  }

  List<Widget> _categoryFilterSlivers() {
    final results = _categoryResults;
    final category = _selectedCategory ?? '';

    return [
      SliverToBoxAdapter(
        child: _sectionTitle(
          '$category Products${results.isNotEmpty ? ' (${results.length})' : ''}',
          'Clear',
          onAction: _clearCategoryFilter,
        ),
      ),
      if (results.isEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 28, 14, 40),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 28,
              ),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: border,
                  width: 0.8,
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: lightGold,
                    size: 28,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No products in this category',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Try another category.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grey,
                      fontSize: 8,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      else
        _productGrid(results),
    ];
  }

  List<Widget> _searchSlivers() {
    final results = _searchResults;

    return [
      SliverToBoxAdapter(
        child: _sectionTitle(
          results.isEmpty
              ? 'Search Results'
              : 'Search Results (${results.length})',
          'Clear',
          onAction: _clearSearch,
        ),
      ),
      if (results.isEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 28, 14, 40),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 28,
              ),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: border,
                  width: 0.8,
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    color: lightGold,
                    size: 28,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No products found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Try a product name or category like shoes, watch, or iPhone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grey,
                      fontSize: 8,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      else
        _productGrid(results),
    ];
  }

  Widget _productGrid(List<Product> products) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        14,
        0,
        14,
        18,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _popular(products[index]),
          childCount: products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 7,
          mainAxisExtent: 108,
        ),
      ),
    );
  }

  // ============================================================
  // SAFE IMAGE
  // Tries the local asset first. If the file is missing, it uses a
  // matching network image so the Home Page still looks complete.
  // ============================================================

  Widget _safeImage(
    String path, {
    BoxFit fit = BoxFit.cover,
    double iconSize = 18,
    String? imageUrl,
  }) {
    final fallbackUrl = imageUrl ?? ProductCatalog.fallbackFor(path);

    Widget placeholder() {
      return Container(
        color: imageBackground,
        alignment: Alignment.center,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: grey,
          size: iconSize,
        ),
      );
    }

    Widget networkImage() {
      if (fallbackUrl == null || fallbackUrl.isEmpty) {
        return placeholder();
      }

      return Image.network(
        fallbackUrl,
        fit: fit,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => placeholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: imageBackground,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 1.4,
                color: gold,
              ),
            ),
          );
        },
      );
    }

    return Image.asset(
      path,
      fit: fit,
      alignment: Alignment.center,
      errorBuilder: (context, error, stackTrace) => networkImage(),
    );
  }

  // ============================================================
  // HEADER BUTTON
  // ============================================================

  Widget _circleButton(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF0E1012),
            shape: BoxShape.circle,
            border: Border.all(
              color: border,
            ),
          ),
          child: Icon(
            icon,
            color: lightGold,
            size: 16,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
    String title,
    String action, {
    VoidCallback? onAction,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        14,
        16,
        14,
        8,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onAction ?? () {},
            child: Text(
              action,
              style: const TextStyle(
                color: lightGold,
                fontSize: 7,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  Widget _category(
    String image,
    String title, {
    String? imageUrl,
  }) {
    return SizedBox(
      width: 62,
      child: GestureDetector(
        onTap: () async {
          final String? category = await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (_) => const CategoryScreen(),
            ),
          );
          if (category != null && category.isNotEmpty) {
            _applyCategoryFilter(category);
          }
        },
        child: Column(
          children: [
            Container(
              height: 53,
              width: 62,
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: border,
                  width: 0.8,
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: _safeImage(
                  image,
                  fit: BoxFit.cover,
                  iconSize: 16,
                  imageUrl: imageUrl,
                ),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: white,
                fontSize: 6.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _space() {
    return const SizedBox(width: 5);
  }

  // ============================================================
  // FEATURED PRODUCT
  // ============================================================

  Widget _featured(Product product) {
    return SizedBox(
      width: 118,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 156,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: border,
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PRODUCT IMAGE
              Container(
                height: 72,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAlias,
                child: _safeImage(
                  product.image,
                  fit: BoxFit.contain,
                  iconSize: 20,
                  imageUrl: product.imageUrl,
                ),
              ),

              const SizedBox(height: 5),

              // PRODUCT NAME
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: white,
                  fontSize: 6.5,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              // RATING
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: lightGold,
                    size: 9,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    product.rating,
                    style: const TextStyle(
                      color: white,
                      fontSize: 6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    product.reviews,
                    style: const TextStyle(
                      color: grey,
                      fontSize: 6,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // PRICE
              Text(
                product.price,
                style: const TextStyle(
                  color: lightGold,
                  fontSize: 7.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuredSpace() {
    return const SizedBox(width: 6);
  }

  // ============================================================
  // POPULAR PRODUCT
  // ============================================================

  Widget _popular(Product product) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: border,
            width: 0.8,
          ),
        ),
        child: Row(
          children: [
            // ----------------------------------------------------
            // LARGE PRODUCT IMAGE
            // ----------------------------------------------------

            SizedBox(
              width: 62,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: imageBackground,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _safeImage(
                    product.image,
                    fit: BoxFit.contain,
                    iconSize: 18,
                    imageUrl: product.imageUrl,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 7),

            // ----------------------------------------------------
            // PRODUCT DETAILS
            // ----------------------------------------------------

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: white,
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: lightGold,
                        size: 9,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.rating,
                        style: const TextStyle(
                          color: white,
                          fontSize: 6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          product.reviews,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: grey,
                            fontSize: 6,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: lightGold,
                      fontSize: 7,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 3),

            // ----------------------------------------------------
            // CART BUTTON
            // ----------------------------------------------------

            Container(
              width: 21,
              height: 21,
              decoration: const BoxDecoration(
                color: gold,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: background,
                size: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BANNER DOT
  // ============================================================

  Widget _dot(bool active) {
    return Container(
      width: active ? 11 : 4,
      height: 4,
      decoration: BoxDecoration(
        color: active ? lightGold : const Color(0xFF555047),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAV
  // ============================================================

  Widget _bottomNav(
    IconData icon,
    String label,
    int index,
  ) {
    final bool active = selectedIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (index == 1) {
            final String? category = await Navigator.push<String>(
              context,
              MaterialPageRoute(
                builder: (_) => const CategoryScreen(),
              ),
            );
            if (category != null && category.isNotEmpty) {
              _applyCategoryFilter(category);
            }
            return;
          }

          setState(() {
            selectedIndex = index;
          });
        },
        child: SizedBox(
          width: 62,
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: active ? lightGold : const Color(0xFF69655E),
              ),

              const SizedBox(height: 3),

              Text(
                label,
                style: TextStyle(
                  color: active ? lightGold : const Color(0xFF69655E),
                  fontSize: 8,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),

              const SizedBox(height: 3),

              if (active)
                Container(
                  width: 16,
                  height: 2,
                  decoration: BoxDecoration(
                    color: lightGold,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
