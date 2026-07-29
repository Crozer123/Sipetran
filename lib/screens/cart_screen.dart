import 'package:flutter/material.dart';

class CartItem {
  final String productName;
  final int quantity;
  final String price;
  final String username;
  final String? imagePath;

  const CartItem({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.username,
    this.imagePath,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color cardColor = Color(0xFFC7DEB1);
  static const Color darkText = Color(0xFF141A10);
  static const Color grayText = Color(0xFF7A8A70);

  final List<CartItem> _cartItems = const [
    CartItem(
      productName: 'Nama Produk',
      quantity: 2,
      price: '20.000',
      username: 'Username',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header Top Row: Back Button ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFF2D5A1B),
                    size: 20,
                  ),
                ),
              ),
            ),

            // ─── Screen Title ─────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Keranjang Saya',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: darkText,
                  letterSpacing: 0.1,
                ),
              ),
            ),

            // ─── Cart Items List ──────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  return _buildCartCard(_cartItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Box placeholder on the left
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: item.imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item.imagePath!,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 14),

          // Detail text & actions column on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3),

                // Quantity (2x)
                Text(
                  '${item.quantity}x',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: grayText,
                  ),
                ),
                const SizedBox(height: 1),

                // Price (20.000)
                Text(
                  item.price,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: grayText,
                  ),
                ),
                const SizedBox(height: 1),

                // Username
                Text(
                  item.username,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 10),

                // Bottom row with buttons: Hapus and Checkout
                Row(
                  children: [
                    // Hapus button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Hapus',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: darkText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Checkout button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9FB98B), // Slightly darker green button color
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: darkText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
