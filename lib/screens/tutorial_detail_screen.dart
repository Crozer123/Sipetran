import 'package:flutter/material.dart';
import '../data/module_data.dart';
import '../widgets/floating_bottom_nav.dart';

class TutorialDetailScreen extends StatefulWidget {
  final String categoryName;
  final String tutorialTitle;
  final String? imagePath;
  final TutorialDetailData? detailData;

  const TutorialDetailScreen({
    super.key,
    required this.categoryName,
    required this.tutorialTitle,
    this.imagePath,
    this.detailData,
  });

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  int _currentIndex = 1;

  static const Color bgColor = Color(0xFFE8F0E1);
  static const Color cardColor = Color(0xFFC7DEB1);
  static const Color darkGreen = Color(0xFF2D5A1B);
  static const Color headerGreen = Color(0xFF3D6B24);
  static const Color darkText = Color(0xFF141A10);

  @override
  Widget build(BuildContext context) {
    final detail = widget.detailData;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Top bar: Back button + Title ────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  GestureDetector(
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
                        color: darkGreen,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.tutorialTitle,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: darkGreen,
                        letterSpacing: 0.1,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // ─── Content ─────────────────────────────────────────────────
            Expanded(
              child: detail != null && detail.sections.isNotEmpty
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: detail.sections.map((section) {
                          return _buildSectionWidget(section);
                        }).toList(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(24),
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
                                        Icons.menu_book_rounded,
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
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }

  // ─── Section Router ──────────────────────────────────────────────────────
  Widget _buildSectionWidget(TutorialSection section) {
    switch (section.type) {
      case SectionType.list:
        return _buildListSection(section);
      case SectionType.steps:
        return _buildStepsSection(section);
      case SectionType.table:
        return _buildTableSection(section);
      case SectionType.summary:
        return _buildSummarySection(section);
    }
  }

  // ─── List Section (Alat / Bahan / Indikator) ──────────────────────────────
  Widget _buildListSection(TutorialSection section) {
    final items = section.items ?? [];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 20,
                decoration: BoxDecoration(
                  color: headerGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                section.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: headerGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4, right: 8),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: headerGreen,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Steps Section (Cara Pembuatan / Langkah Cuci Tangan) ────────────────
  Widget _buildStepsSection(TutorialSection section) {
    final steps = section.items ?? [];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 20,
                decoration: BoxDecoration(
                  color: headerGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                section.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: headerGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...steps.asMap().entries.map((entry) {
            final idx = entry.key + 1;
            final stepText = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: headerGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$idx',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: bgColor.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        stepText,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─── Table Section (Kandungan Gizi) ──────────────────────────────────────
  Widget _buildTableSection(TutorialSection section) {
    final headers = section.tableHeaders ?? [];
    final rows = section.tableRows ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 20,
                decoration: BoxDecoration(
                  color: headerGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: headerGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(cardColor),
                dataRowMinHeight: 34,
                dataRowMaxHeight: 40,
                columnSpacing: 16,
                columns: headers.map((h) {
                  return DataColumn(
                    label: Text(
                      h,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: darkGreen,
                      ),
                    ),
                  );
                }).toList(),
                rows: rows.map((row) {
                  final isTotal = row['Bahan'] == 'TOTAL';
                  return DataRow(
                    color: isTotal
                        ? WidgetStateProperty.all(const Color(0xFFFFF7D6))
                        : null,
                    cells: headers.map((h) {
                      final val = row[h] ?? '-';
                      return DataCell(
                        Text(
                          val,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
                            color: isTotal ? const Color(0xFF8B6B00) : darkText,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Summary Section (Sajian & AKG) ──────────────────────────────────────
  Widget _buildSummarySection(TutorialSection section) {
    final summaryMap = section.summaryData ?? {};
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD8EBC7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: headerGreen, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stars_rounded, color: headerGreen, size: 22),
              const SizedBox(width: 8),
              Text(
                section.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: headerGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...summaryMap.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      entry.value,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: darkText,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
