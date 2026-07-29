import 'package:flutter/material.dart';
import '../widgets/floating_bottom_nav.dart';
import 'tutorial_detail_screen.dart';

// ─── Data model for a tutorial sub-item ────────────────────────────────────
class TutorialItem {
  final String title;
  final String? imagePath; // optional image asset path

  const TutorialItem({required this.title, this.imagePath});
}

// ─── CategoryDetailScreen ──────────────────────────────────────────────────
class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;
  final String categoryImage;
  final List<TutorialItem> tutorials;

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.categoryImage,
    required this.tutorials,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  int _currentIndex = 1;

  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color cardColor = Color(0xFFC7DEB1);
  static const Color stripColor = Color(0xFF9EBE82);
  static const Color darkGreen = Color(0xFF2D5A1B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Top bar: Back + Title ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: darkGreen,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.categoryName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),

            // ─── Tutorial Cards List ──────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: widget.tutorials.length,
                itemBuilder: (context, index) {
                  return _buildTutorialCard(widget.tutorials[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  // ─── Tutorial Card ────────────────────────────────────────────────────────
  Widget _buildTutorialCard(TutorialItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TutorialDetailScreen(
              categoryName: widget.categoryName,
              tutorialTitle: item.title,
              imagePath: item.imagePath,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              // Upper image area
              Expanded(
                child: item.imagePath != null
                    ? Image.asset(
                        item.imagePath!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Container(
                        color: cardColor,
                      ),
              ),

              // Bottom label strip
              Container(
                width: double.infinity,
                color: stripColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A2E10),
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
