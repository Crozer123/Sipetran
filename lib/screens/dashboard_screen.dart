import 'package:flutter/material.dart';
import '../widgets/floating_bottom_nav.dart';
import 'category_detail_screen.dart';
import 'pesanan_screen.dart';
import 'cart_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String username;

  const DashboardScreen({super.key, required this.username});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 1; // Home is middle tab

  // Sage green palette
  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color darkGreen = Color(0xFF2D5A1B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: _buildHeader(),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSearchBar(),
              ),
              const SizedBox(height: 16),

              // Banner carousel card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildBannerCard(),
              ),
              const SizedBox(height: 24),

              // 8 categories in 2 rows of 4
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildCategoriesGrid(),
              ),
              const SizedBox(height: 24),

              // Produk section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildProdukSection(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            // Navigate to Pesanan screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PesananScreen(),
              ),
            );
          } else {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'SIPETRAN',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
            color: darkGreen,
          ),
        ),
        Row(
          children: [
            // Username from login
            Text(
              widget.username,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: darkGreen,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Search Bar ───────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: darkGreen.withValues(alpha: 0.45),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: darkGreen.withValues(alpha: 0.5),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // ─── Banner Card ──────────────────────────────────────────────────────────
  Widget _buildBannerCard() {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: const Color(0xFFC7DEB1), // Pastel sage green from reference image
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Main content
          Row(
            children: [
              // Quote Text Area
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '“Ayo jaga lingkungan kita demi menciptakan hidup yang bersih, sehat dan lestari”',
                        style: TextStyle(
                          color: Colors.white, // Pure white text from reference image
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Illustration Area
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 24, top: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/sipetran_banner.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Carousel indicator dots INSIDE card at bottom
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bannerDot(active: true),
                const SizedBox(width: 8),
                _bannerDot(active: false),
                const SizedBox(width: 8),
                _bannerDot(active: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bannerDot({required bool active}) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.black.withValues(alpha: 0.22),
        shape: BoxShape.circle,
      ),
    );
  }

  // ─── Categories Grid (2 rows × 4 cols) ───────────────────────────────────
  Widget _buildCategoriesGrid() {
    final categories = [
      _CategoryItem('Nugget SIJAGO', 'assets/images/nugget_sijago.png', _defaultTutorials('Nugget SIJAGO')),
      _CategoryItem('SILOKA', 'assets/images/kopi_siloka.png', _defaultTutorials('SILOKA')),
      _CategoryItem('Kebun Gizi', 'assets/images/cat_kebun_gizi.png', _defaultTutorials('Kebun Gizi')),
      _CategoryItem('PHBS', 'assets/images/cat_phbs.png', _defaultTutorials('PHBS')),
      _CategoryItem('Biopori', 'assets/images/cat_biopori.png', _defaultTutorials('Biopori')),
      _CategoryItem('Alat Pembakar\nSampah', 'assets/images/cat_alat_pembakar.png', _defaultTutorials('Alat Pembakar Sampah')),
      _CategoryItem('Pemasaran', 'assets/images/cat_pemasaran.png', _defaultTutorials('Pemasaran')),
      _CategoryItem('Kompos Kotoran\nHewan', 'assets/images/cat_kompos.png', _defaultTutorials('Kompos Kotoran Hewan')),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.67,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryCell(categories[index]);
      },
    );
  }

  List<TutorialItem> _defaultTutorials(String categoryName) {
    return [
      TutorialItem(title: 'Tutorkan'),
      TutorialItem(title: 'Tutorkan'),
      TutorialItem(title: 'Tutorkan'),
    ];
  }

  Widget _buildCategoryCell(_CategoryItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryDetailScreen(
              categoryName: item.label.replaceAll('\n', ' '),
              categoryImage: item.imagePath,
              tutorials: item.tutorials,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon box matching the reference image soft sage green rounded card
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFC7DEB1), // Exact pastel green card color from reference image
                borderRadius: BorderRadius.circular(28),
              ),
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900, // Extra bold black text from reference image
              color: Color(0xFF141A10),
              letterSpacing: -0.2,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Produk Section ───────────────────────────────────────────────────────
  Widget _buildProdukSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1),
          ),
          child: Column(
            children: [
              Icon(
                Icons.storefront_outlined,
                size: 44,
                color: darkGreen.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 10),
              Text(
                'Belum ada produk yang dijual',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: darkGreen.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Produk akan ditambahkan oleh Penjual',
                style: TextStyle(
                  fontSize: 11,
                  color: darkGreen.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}

// ─── Data classes ─────────────────────────────────────────────────────────────
class _CategoryItem {
  final String label;
  final String imagePath;
  final List<TutorialItem> tutorials;
  _CategoryItem(this.label, this.imagePath, this.tutorials);
}
