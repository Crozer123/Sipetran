import 'package:flutter/material.dart';
import '../widgets/floating_bottom_nav.dart';

// ─── Product Model ─────────────────────────────────────────────────────────
class Product {
  String id;
  String name;
  String category;
  double price;
  int stock;
  String description;
  String? imagePath;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    this.imagePath,
  });
}

// ─── Toko Screen ───────────────────────────────────────────────────────────
class TokoScreen extends StatefulWidget {
  const TokoScreen({super.key});

  @override
  State<TokoScreen> createState() => _TokoScreenState();
}

class _TokoScreenState extends State<TokoScreen>
    with SingleTickerProviderStateMixin {
  int _currentNavIndex = 2;
  late TabController _tabController;

  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color cardColor = Color(0xFFC7DEB1);
  static const Color darkGreen = Color(0xFF2D5A1B);
  static const Color headerGreen = Color(0xFF3D6B24);
  static const Color darkText = Color(0xFF141A10);
  static const Color grayText = Color(0xFF7A8A70);

  // ─── Sample Products (Nugget SIJAGO & SILOKA Only) ───────────────────────
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Nugget SIJAGO',
      category: 'Kuliner Sehat',
      price: 20000,
      stock: 15,
      description: 'Nugget berbasis Jagung + Kelor bergizi tinggi, 266.37 kkal & 23% AKG Protein.',
      imagePath: 'assets/images/nugget_sijago.png',
    ),
    Product(
      id: '2',
      name: 'Kopi SILOKA',
      category: 'Ekonomi Kreatif',
      price: 35000,
      stock: 20,
      description: 'Kopi Robusta Gunungsari + Jahe + Sereh. Resting 4-7 hari untuk aroma terbaik.',
      imagePath: 'assets/images/kopi_siloka.png',
    ),
  ];

  // ─── SOP Steps ────────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _sopSteps = [
    {
      'icon': Icons.inventory_2_rounded,
      'color': const Color(0xFF3D6B24),
      'title': 'Standar Kualitas & Kemasan',
      'desc': 'Gunakan kemasan vakum untuk Nugget SIJAGO agar tahan 3-5 hari. Kopi SILOKA dikemas dalam standing pouch berkatup aroma. Beri label nama produk, berat bersih, dan tanggal produksi.',
    },
    {
      'icon': Icons.calculate_rounded,
      'color': const Color(0xFFB45309),
      'title': 'Penetapan Harga Jual (HPP)',
      'desc': 'Hitung Harga Pokok Penjualan (HPP): Total Biaya Bahan Baku ÷ Jumlah Produksi. Tambahkan margin keuntungan 20-30% untuk UMKM lokal. Perbarui harga secara berkala sesuai kondisi pasar.',
    },
    {
      'icon': Icons.published_with_changes_rounded,
      'color': const Color(0xFF1565C0),
      'title': 'Alur Respon Pesanan',
      'desc': 'Pesanan masuk → Tab Pesanan (Status: Aktif) → Tekan "Terima" untuk konfirmasi → Siapkan produk → Tekan "Selesai" setelah dikirim. Stok akan berkurang otomatis saat pesanan diterima.',
    },
    {
      'icon': Icons.camera_alt_rounded,
      'color': const Color(0xFF7B1FA2),
      'title': 'Tips Foto & Deskripsi Produk',
      'desc': 'Foto produk di latar putih atau hijau alami dengan cahaya terang. Sertakan deskripsi jelas: kandungan gizi, berat, bahan utama, dan cara penyimpanan. Foto yang baik meningkatkan kepercayaan pembeli.',
    },
    {
      'icon': Icons.local_shipping_rounded,
      'color': const Color(0xFF00796B),
      'title': 'Manajemen Stok & Pembaruan',
      'desc': 'Perbarui stok setiap ada produksi baru. Tandai produk dengan stok "0" sebagai tidak tersedia. Lakukan pencatatan stok harian untuk menghindari overselling dan memastikan kepuasan pembeli.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ──────────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                'Toko Saya',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: darkText,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                'Kelola produk UMKM Desa Gunungsari',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: grayText,
                ),
              ),
            ),

            // ─── Tab Bar ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                dividerColor: Colors.transparent,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: headerGreen, width: 2.5),
                  insets: EdgeInsets.symmetric(horizontal: 4),
                ),
                labelColor: headerGreen,
                unselectedLabelColor: grayText,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'Kelola Produk'),
                  Tab(text: 'Tata Cara Kelola'),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // ─── Tab Views ───────────────────────────────────────────────
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProductTab(),
                  _buildSopTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      // ─── FAB: Tambah Produk ─────────────────────────────────────────────
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (context, _) {
          if (_tabController.index == 0) {
            return FloatingActionButton.extended(
              onPressed: () => _showProductForm(context),
              backgroundColor: headerGreen,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text(
                'Tambah Produk',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pop();
          } else if (index == 0) {
            Navigator.of(context).pop();
          } else {
            setState(() => _currentNavIndex = index);
          }
        },
      ),
    );
  }

  // ─── Tab 1: Produk Grid ───────────────────────────────────────────────────
  Widget _buildProductTab() {
    if (_products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store_mall_directory_outlined,
                size: 72, color: grayText.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            const Text(
              'Belum ada produk',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: grayText),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tekan tombol "+ Tambah Produk" untuk memulai',
              style: TextStyle(fontSize: 12, color: grayText),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      children: _products.map((p) => _buildProductCard(p)).toList(),
    );
  }

  // ─── Product Card ─────────────────────────────────────────────────────────
  Widget _buildProductCard(Product product) {
    final bool inStock = product.stock > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cardColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Product Image ─────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 78,
                height: 78,
                color: cardColor,
                child: product.imagePath != null
                    ? Image.asset(product.imagePath!, fit: BoxFit.cover)
                    : Icon(Icons.shopping_bag_outlined,
                        color: darkGreen.withValues(alpha: 0.5), size: 36),
              ),
            ),
            const SizedBox(width: 12),

            // ── Info ───────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge + Stock badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.category,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: headerGreen),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: inStock
                              ? const Color(0xFFDCF0D0)
                              : const Color(0xFFFFE0E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          inStock
                              ? 'Stok: ${product.stock}'
                              : 'Habis',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: inStock
                                ? const Color(0xFF2D5A1B)
                                : const Color(0xFFC0392B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Price
                  Text(
                    'Rp ${_formatPrice(product.price)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: headerGreen,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Description
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: grayText),
                  ),
                  const SizedBox(height: 8),

                  // Edit & Delete buttons
                  Row(
                    children: [
                      _actionBtn(
                        label: 'Edit',
                        icon: Icons.edit_rounded,
                        bgColor: cardColor,
                        textColor: darkGreen,
                        onTap: () => _showProductForm(context, product: product),
                      ),
                      const SizedBox(width: 8),
                      _actionBtn(
                        label: 'Hapus',
                        icon: Icons.delete_rounded,
                        bgColor: const Color(0xFFFFE0E0),
                        textColor: const Color(0xFFC0392B),
                        onTap: () => _confirmDelete(product),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: textColor)),
          ],
        ),
      ),
    );
  }

  // ─── Tab 2: SOP Cards ────────────────────────────────────────────────────
  Widget _buildSopTab() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: _sopSteps.length,
      itemBuilder: (context, index) {
        final step = _sopSteps[index];
        final Color accent = step['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: cardColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step number + icon
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(step['icon'] as IconData, color: accent, size: 22),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['title'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      step['desc'] as String,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: darkText,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Add / Edit Product Form ──────────────────────────────────────────────
  void _showProductForm(BuildContext context, {Product? product}) {
    final isEdit = product != null;
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final priceCtrl = TextEditingController(
        text: isEdit ? product.price.toStringAsFixed(0) : '');
    final stockCtrl =
        TextEditingController(text: isEdit ? product.stock.toString() : '');
    final descCtrl = TextEditingController(text: product?.description ?? '');
    String selectedCategory = product?.category ?? 'Kuliner Sehat';
    final categories = [
      'Kuliner Sehat',
      'Ekonomi Kreatif',
      'Lingkungan',
      'Kebun Gizi',
    ];

    String? selectedImagePath = product?.imagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.88,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          builder: (_, scrollCtrl) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: ListView(
              controller: scrollCtrl,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isEdit ? 'Edit Produk' : 'Tambah Produk Baru',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Lengkapi informasi produk UMKM Desa Gunungsari',
                  style: TextStyle(fontSize: 12, color: grayText),
                ),
                const SizedBox(height: 16),

                // ─── Upload Foto Produk Section ─────────────────────────────
                _formLabel('Foto Produk'),
                GestureDetector(
                  onTap: () {
                    // Toggle sample assets or select image
                    setModalState(() {
                      if (selectedImagePath == 'assets/images/nugget_sijago.png') {
                        selectedImagePath = 'assets/images/kopi_siloka.png';
                      } else {
                        selectedImagePath = 'assets/images/nugget_sijago.png';
                      }
                    });
                  },
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: headerGreen.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: selectedImagePath != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  selectedImagePath!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.photo_camera_rounded,
                                        color: Colors.white, size: 28),
                                    SizedBox(height: 4),
                                    Text(
                                      'Ganti Foto Produk',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.cloud_upload_rounded,
                                  color: headerGreen, size: 36),
                              SizedBox(height: 6),
                              Text(
                                'Klik untuk Unggah Foto Produk',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: headerGreen,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Format JPG / PNG (Maks 5MB)',
                                style: TextStyle(fontSize: 10, color: grayText),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 14),

                // Name
                _formLabel('Nama Produk'),
                _formField(
                  controller: nameCtrl,
                  hint: 'cth: Nugget SIJAGO 100gr',
                ),
                const SizedBox(height: 14),

                // Category
                _formLabel('Kategori'),
                Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cardColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: headerGreen),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: darkText),
                      items: categories
                          .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setModalState(() => selectedCategory = val);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Price & Stock row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formLabel('Harga (Rp)'),
                          _formField(
                            controller: priceCtrl,
                            hint: 'cth: 20000',
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formLabel('Stok'),
                          _formField(
                            controller: stockCtrl,
                            hint: 'cth: 10',
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Description
                _formLabel('Deskripsi Produk'),
                _formField(
                  controller: descCtrl,
                  hint:
                      'Tulis keunggulan, kandungan gizi, atau cara penyimpanan produk...',
                  maxLines: 4,
                ),
                const SizedBox(height: 24),

                // Submit button
                GestureDetector(
                  onTap: () {
                    final name = nameCtrl.text.trim();
                    final priceRaw = double.tryParse(priceCtrl.text.trim());
                    final stockRaw = int.tryParse(stockCtrl.text.trim());
                    final desc = descCtrl.text.trim();

                    if (name.isEmpty || priceRaw == null || stockRaw == null) {
                      return;
                    }

                    setState(() {
                      if (isEdit) {
                        product.name = name;
                        product.category = selectedCategory;
                        product.price = priceRaw;
                        product.stock = stockRaw;
                        product.description = desc;
                        product.imagePath = selectedImagePath;
                      } else {
                        _products.add(Product(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: name,
                          category: selectedCategory,
                          price: priceRaw,
                          stock: stockRaw,
                          description: desc,
                          imagePath: selectedImagePath ?? 'assets/images/nugget_sijago.png',
                        ));
                      }
                    });

                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: headerGreen,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      isEdit ? 'Simpan Perubahan' : 'Tambah Produk',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w800, color: darkGreen)),
    );
  }

  Widget _formField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: darkText),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            const TextStyle(fontSize: 13, color: grayText, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: bgColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cardColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cardColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: headerGreen, width: 2),
        ),
      ),
    );
  }

  // ─── Delete Confirmation Dialog ───────────────────────────────────────────
  void _confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Hapus Produk?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: darkText),
        ),
        content: Text(
          'Produk "${product.name}" akan dihapus secara permanen.',
          style: const TextStyle(fontSize: 13, color: grayText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: grayText)),
          ),
          GestureDetector(
            onTap: () {
              setState(() => _products.removeWhere((p) => p.id == product.id));
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFC0392B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────
  String _formatPrice(double price) {
    final parts = price.toStringAsFixed(0).split('');
    final result = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      if (i != 0 && (parts.length - i) % 3 == 0) result.write('.');
      result.write(parts[i]);
    }
    return result.toString();
  }
}


