import 'package:flutter/material.dart';
import '../widgets/floating_bottom_nav.dart';

// ─── TutorialDetailScreen ──────────────────────────────────────────────────
class TutorialDetailScreen extends StatefulWidget {
  final String categoryName;
  final String tutorialTitle;
  final String? imagePath;

  const TutorialDetailScreen({
    super.key,
    required this.categoryName,
    required this.tutorialTitle,
    this.imagePath,
  });

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  int _currentIndex = 1;

  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color cardColor = Color(0xFFC7DEB1);
  static const Color darkGreen = Color(0xFF2D5A1B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Top bar: Back button ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: GestureDetector(
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
            ),

            // ─── Full-screen content card ─────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: widget.imagePath != null
                        ? Image.asset(
                            widget.imagePath!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 64,
                                  color: darkGreen.withValues(alpha: 0.3),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.tutorialTitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: darkGreen.withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
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


}
