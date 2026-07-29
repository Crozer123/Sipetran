import 'package:flutter/material.dart';
import '../widgets/floating_bottom_nav.dart';

// ─── Order Data Model ──────────────────────────────────────────────────────
enum OrderStatus { aktif, proses, selesai, dibatalkan }

class OrderItem {
  final String username;
  final int quantity;
  final String productName;
  final String? imagePath;

  const OrderItem({
    required this.username,
    required this.quantity,
    required this.productName,
    this.imagePath,
  });
}

// ─── PesananScreen ─────────────────────────────────────────────────────────
class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen>
    with SingleTickerProviderStateMixin {
  int _currentNavIndex = 0; // Pesanan tab is index 0
  late TabController _tabController;

  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color cardColor = Color(0xFFD4E8BC);
  static const Color activeTabColor = Color(0xFF3D6B24);
  static const Color inactiveTabColor = Color(0xFF8A9E7A);
  static const Color darkText = Color(0xFF141A10);
  static const Color grayText = Color(0xFF7A8A70);


  // Sample orders for each tab
  final List<OrderItem> _sampleOrders = const [
    OrderItem(username: 'Username', quantity: 2, productName: 'Nama Produk'),
    OrderItem(username: 'Username', quantity: 2, productName: 'Nama Produk'),
    OrderItem(username: 'Username', quantity: 2, productName: 'Nama Produk'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Pesanan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: darkText,
                  letterSpacing: 0.2,
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
                  borderSide: BorderSide(
                    color: Color(0xFF3D6B24),
                    width: 2.5,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 4),
                ),
                labelColor: activeTabColor,
                unselectedLabelColor: inactiveTabColor,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'Aktif'),
                  Tab(text: 'Proses'),
                  Tab(text: 'Selesai'),
                  Tab(text: 'Dibatalkan'),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // ─── Tab Views ───────────────────────────────────────────────
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderList(OrderStatus.aktif),
                  _buildOrderList(OrderStatus.proses),
                  _buildOrderList(OrderStatus.selesai),
                  _buildOrderList(OrderStatus.dibatalkan),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 1) {
            // Home — go back to Dashboard
            Navigator.of(context).pop();
          } else {
            setState(() => _currentNavIndex = index);
          }
        },
      ),
    );
  }

  // ─── Order List ──────────────────────────────────────────────────────────
  Widget _buildOrderList(OrderStatus status) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: _sampleOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(_sampleOrders[index], status);
      },
    );
  }

  // ─── Order Card ──────────────────────────────────────────────────────────
  Widget _buildOrderCard(OrderItem order, OrderStatus status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image placeholder ───────────────────────────────────────
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: order.imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      order.imagePath!,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),

          // ── Order info + actions ────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username
                Text(
                  order.username,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: grayText,
                  ),
                ),
                const SizedBox(height: 2),
                // Quantity
                Text(
                  '${order.quantity}x',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: grayText,
                  ),
                ),
                const SizedBox(height: 2),
                // Product name
                Text(
                  order.productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 10),

                // ── Action area ────────────────────────────────────
                _buildActionArea(status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Action Area per Status ──────────────────────────────────────────────
  Widget _buildActionArea(OrderStatus status) {
    switch (status) {
      case OrderStatus.aktif:
        return Row(
          children: [
            // Tolak button
            Expanded(
              child: _actionButton(
                label: 'Tolak',
                bgColor: const Color(0xFFB0C49A),
                textColor: const Color(0xFF2D4A1E),
                bold: false,
              ),
            ),
            const SizedBox(width: 8),
            // Terima button
            Expanded(
              child: _actionButton(
                label: 'Terima',
                bgColor: Colors.white,
                textColor: const Color(0xFF141A10),
                bold: true,
              ),
            ),
          ],
        );

      case OrderStatus.proses:
        return SizedBox(
          width: double.infinity,
          child: _actionButton(
            label: 'Selesai',
            bgColor: const Color(0xFFB8CCA4),
            textColor: const Color(0xFF2D4A1E),
            bold: true,
          ),
        );

      case OrderStatus.selesai:
        return const Text(
          'Diselesaikan',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: grayText,
          ),
        );

      case OrderStatus.dibatalkan:
        return const Text(
          'Ditolak',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: grayText,
          ),
        );
    }
  }

  Widget _actionButton({
    required String label,
    required Color bgColor,
    required Color textColor,
    required bool bold,
  }) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w900 : FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
