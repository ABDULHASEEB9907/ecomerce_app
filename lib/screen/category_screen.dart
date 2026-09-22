import 'package:flutter/material.dart';
import '../data/product_catalog.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // ============================================================
  // SEARCH
  // ============================================================

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // ============================================================
  // COLORS
  // ============================================================

  static const Color background = Color(0xFF080705);
  static const Color card = Color(0xFF11100D);
  static const Color imageBackground = Color(0xFF171613);
  static const Color border = Color(0xFF3D3728);
  static const Color gold = Color(0xFFC5A33D);
  static const Color lightGold = Color(0xFFD2B24C);
  static const Color white = Color(0xFFF5F2EA);
  static const Color grey = Color(0xFF8D8981);

  // ============================================================
  // FILTERED CATEGORIES
  // ============================================================

  List<dynamic> get _filteredCategories {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return ProductCatalog.categories;
    }

    return ProductCatalog.categories.where((category) {
      return category.name.toLowerCase().contains(query);
    }).toList();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  // ============================================================
  // CLEAR SEARCH
  // ============================================================

  void _clearSearch() {
    searchController.clear();
    searchFocusNode.unfocus();

    setState(() {});
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final categories = _filteredCategories;

    return Scaffold(
      backgroundColor: background,

      // ==========================================================
      // APP BAR
      // ==========================================================

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        // BACK BUTTON
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: white,
            size: 22,
          ),
          tooltip: 'Back',
        ),

        title: const Text(
          'Categories',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ==========================================================
      // BODY
      // ==========================================================

      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            final double contentWidth =
                screenWidth > 430 ? 430.0 : screenWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [

                    // ==================================================
                    // EXPLORE ALL CATEGORIES SEARCH
                    // ==================================================

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          14,
                          4,
                          14,
                          0,
                        ),
                        child: Container(
                          height: 40,
                          width: double.infinity,
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

                              // SEARCH ICON
                              const Icon(
                                Icons.search_rounded,
                                color: Color(0xFF9A958C),
                                size: 17,
                              ),

                              const SizedBox(width: 8),

                              // SEARCH FIELD
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  focusNode: searchFocusNode,
                                  onChanged: (_) {
                                    setState(() {});
                                  },
                                  cursorColor: gold,
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: 9,
                                  ),
                                  textInputAction:
                                      TextInputAction.search,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText:
                                        'Explore all categories',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF77736C),
                                      fontSize: 9,
                                    ),
                                    contentPadding:
                                        EdgeInsets.zero,
                                  ),
                                ),
                              ),

                              // CLEAR BUTTON / GRID ICON
                              if (searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: _clearSearch,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color:
                                          Color(0xFF9A958C),
                                      size: 16,
                                    ),
                                  ),
                                )
                              else
                                const Padding(
                                  padding:
                                      EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.grid_view_rounded,
                                    color: lightGold,
                                    size: 16,
                                  ),
                                ),

                              if (searchController.text.isNotEmpty)
                                const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ==================================================
                    // ALL CATEGORIES HEADER
                    // ==================================================

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          14,
                          20,
                          14,
                          10,
                        ),
                        child: Row(
                          children: [

                            Text(
                              searchController.text.trim().isEmpty
                                  ? 'All Categories'
                                  : 'Search Categories',
                              style: const TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              '${categories.length} Categories',
                              style: const TextStyle(
                                color: grey,
                                fontSize: 7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ==================================================
                    // NO CATEGORIES
                    // ==================================================

                    if (categories.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            14,
                            28,
                            14,
                            40,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 28,
                            ),
                            decoration: BoxDecoration(
                              color: card,
                              borderRadius:
                                  BorderRadius.circular(8),
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
                                  'No categories found',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  'Try another category name.',
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

                    // ==================================================
                    // CATEGORY GRID
                    // ==================================================

                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          14,
                          0,
                          14,
                          24,
                        ),
                        sliver: SliverGrid(
                          delegate:
                              SliverChildBuilderDelegate(
                            (context, index) {
                              final category =
                                  categories[index];

                              return _categoryCard(
                                context,
                                category.image,
                                category.name,
                                category.imageUrl,
                              );
                            },
                            childCount: categories.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY CARD
  // ============================================================

  Widget _categoryCard(
    BuildContext context,
    String image,
    String title,
    String? imageUrl,
  ) {
    return GestureDetector(
      onTap: () {
        // Selected category Home Screen ko return hogi
        Navigator.pop(context, title);
      },

      child: Container(
        padding: const EdgeInsets.all(6),

        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: border,
            width: 0.8,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ========================================================
            // IMAGE
            // ========================================================

            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: imageBackground,
                  borderRadius: BorderRadius.circular(7),
                ),

                clipBehavior: Clip.antiAlias,

                child: _safeImage(
                  image,
                  imageUrl: imageUrl,
                ),
              ),
            ),

            const SizedBox(height: 7),

            // ========================================================
            // CATEGORY NAME
            // ========================================================

            Padding(
              padding: const EdgeInsets.only(
                left: 2,
                bottom: 2,
              ),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: white,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SAFE IMAGE
  // ============================================================

  Widget _safeImage(
    String path, {
    String? imageUrl,
  }) {
    final fallbackUrl =
        imageUrl ?? ProductCatalog.fallbackFor(path);

    Widget placeholder() {
      return Container(
        color: imageBackground,
        alignment: Alignment.center,

        child: const Icon(
          Icons.image_not_supported_outlined,
          color: grey,
          size: 24,
        ),
      );
    }

    // ------------------------------------------------------------
    // NO NETWORK FALLBACK
    // ------------------------------------------------------------

    if (fallbackUrl == null || fallbackUrl.isEmpty) {
      return Image.asset(
        path,
        fit: BoxFit.cover,

        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return placeholder();
        },
      );
    }

    // ------------------------------------------------------------
    // ASSET → NETWORK FALLBACK
    // ------------------------------------------------------------

    return Image.asset(
      path,
      fit: BoxFit.cover,

      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return Image.network(
          fallbackUrl,
          fit: BoxFit.cover,
          alignment: Alignment.center,

          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return placeholder();
          },

          loadingBuilder: (
            context,
            child,
            loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            }

            return Container(
              color: imageBackground,
              alignment: Alignment.center,

              child: const SizedBox(
                width: 16,
                height: 16,

                child: CircularProgressIndicator(
                  strokeWidth: 1.4,
                  color: gold,
                ),
              ),
            );
          },
        );
      },
    );
  }
}