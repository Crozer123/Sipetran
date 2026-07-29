import '../screens/category_detail_screen.dart';

enum SectionType { list, steps, table, summary }

class TutorialSection {
  final String title;
  final SectionType type;
  final List<String>? items;
  final Map<String, List<String>>? groupedItems;
  final List<Map<String, String>>? tableRows;
  final List<String>? tableHeaders;
  final Map<String, String>? summaryData;

  const TutorialSection({
    required this.title,
    required this.type,
    this.items,
    this.groupedItems,
    this.tableRows,
    this.tableHeaders,
    this.summaryData,
  });
}

class TutorialDetailData {
  final String title;
  final String categoryName;
  final String? imagePath;
  final List<TutorialSection> sections;

  const TutorialDetailData({
    required this.title,
    required this.categoryName,
    this.imagePath,
    required this.sections,
  });
}

class ModuleData {
  static List<TutorialItem> getTutorialItems(String categoryName) {
    final details = getCategoryDetails(categoryName);
    return details.map((detail) {
      return TutorialItem(
        title: detail.title,
        imagePath: detail.imagePath,
        detailData: detail,
      );
    }).toList();
  }

  static List<TutorialDetailData> getCategoryDetails(String categoryName) {
    final normalized = categoryName.toLowerCase().trim();

    if (normalized.contains('sijago') || normalized.contains('nugget')) {
      return _sijagoModules;
    } else if (normalized.contains('phbs')) {
      return _phbsModules;
    } else if (normalized.contains('siloka') || normalized.contains('kopi') || normalized.contains('pemasaran')) {
      return _silokaModules;
    } else if (normalized.contains('biopori')) {
      return _bioporiModules;
    } else if (normalized.contains('pembakar') || normalized.contains('sampah')) {
      return _alatPembakarModules;
    } else if (normalized.contains('kompos')) {
      return _komposModules;
    } else if (normalized.contains('kebun') || normalized.contains('gizi')) {
      return _kebunGiziModules;
    }

    return _defaultModules(categoryName);
  }

  // ─── NUGGET SIJAGO ────────────────────────────────────────────────────────
  static final List<TutorialDetailData> _sijagoModules = [
    const TutorialDetailData(
      title: '1. Alat dan Bahan',
      categoryName: 'Nugget SIJAGO',
      imagePath: 'assets/images/nugget_sijago.png',
      sections: [
        TutorialSection(
          title: 'Bahan-Bahan',
          type: SectionType.list,
          items: [
            'Jagung segar 35 gr',
            'Kelor 15 gr',
            'Dada ayam 30 gr',
            'Daun bawang 15 gr',
            'Tepung terigu 5 gr',
            'Tepung tapioka 10 gr',
            'Tepung panir secukupnya',
            'Bawang merah 5 gr',
            'Bawang putih 4 gr',
            'Garam 2 gr',
            'Kaldu jamur 2 gr',
            'Gula 2 gr',
            'Minyak goreng secukupnya',
            'Telur ayam 15 gr',
            'Merica 1 gr',
            'Air dingin sekitar (5-10 mL) atau es batu',
          ],
        ),
        TutorialSection(
          title: 'Alat-Alat',
          type: SectionType.list,
          items: [
            'Chopper',
            'Panci kecil',
            'Panci kukusan',
            'Pisau',
            'Talenan',
            'Baskom / mangkok',
            'Serbet / lap',
            'Loyang',
            'Sendok',
            'Kompor',
            'Timbangan',
            'Gas',
            'Wajan',
            'Spatula',
            'Peniris minyak',
            'Solet',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '2. Cara Pembuatan',
      categoryName: 'Nugget SIJAGO',
      imagePath: 'assets/images/nugget_sijago.png',
      sections: [
        TutorialSection(
          title: 'Langkah Pembuatan Nugget SIJAGO',
          type: SectionType.steps,
          items: [
            'Cuci jagung, pipil lalu timbang sebesar 35 gr, haluskan dengan chopper.',
            'Pisahkan kelor dengan batang, lalu timbang kelor sebesar 15 gr dan cuci kelor.',
            'Siapkan air yang dipanaskan hingga mendidih, lalu masukkan kelor dan rebus kelor selama 2-3 menit dan tiriskan.',
            'Peras kelor sampai air di dalamnya berkurang lalu cincang kelor sampai halus.',
            'Cuci ayam, pisahkan kulit dan daging ayam, ambil dan timbang daging ayam sebesar 30 gr.',
            'Masukkan ayam, jagung yang sudah di-chopper, tepung terigu & tapioka, telur ayam, kaldu jamur, garam, gula, merica, bawang merah, bawang putih, daun bawang, dan es batu secukupnya.',
            'Setelah halus semua, campurkan dengan kelor yang sudah dicacah halus dan aduk dengan sendok.',
            'Siapkan cetakan/loyang yang sudah dilumuri dengan minyak goreng, masukkan adonan ke dalam loyang.',
            'Siapkan kukusan dan tunggu air hingga mendidih, lalu masukkan adonan yang sudah dimasukkan ke dalam loyang, kukus selama 25-30 menit.',
            'Setelah matang, dinginkan selama 15-30 menit sebelum dipotong.',
            'Siapkan adonan basah (tepung terigu dan air) dan adonan kering (tepung panir), setelah adonan dipotong dengan berat ±25 gr, masukkan ke dalam adonan basah lalu ke adonan kering (padatkan).',
            'Setelah semua dilumuri dengan tepung panir, goreng nugget di api sedang hingga kecoklatan.',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '3. Kandungan Gizi',
      categoryName: 'Nugget SIJAGO',
      imagePath: 'assets/images/nugget_sijago.png',
      sections: [
        TutorialSection(
          title: 'Tabel Kandungan Gizi Per Bahan',
          type: SectionType.table,
          tableHeaders: ['Bahan', 'Jumlah', 'Energi (kkal)', 'KH (g)', 'Protein (g)', 'Lemak (g)', 'Zat Besi (mg)'],
          tableRows: [
            {'Bahan': 'Jagung Segar', 'Jumlah': '35 gr', 'Energi (kkal)': '128.1', 'KH (g)': '24.19', 'Protein (g)': '3.43', 'Lemak (g)': '2.56', 'Zat Besi (mg)': '0.81'},
            {'Bahan': 'Kelor', 'Jumlah': '15 gr', 'Energi (kkal)': '13.8', 'KH (g)': '2.15', 'Protein (g)': '0.77', 'Lemak (g)': '0.24', 'Zat Besi (mg)': '0.9'},
            {'Bahan': 'Dada Ayam', 'Jumlah': '30 gr', 'Energi (kkal)': '31.8', 'KH (g)': '0', 'Protein (g)': '6.75', 'Lemak (g)': '0.58', 'Zat Besi (mg)': '0.11'},
            {'Bahan': 'Tepung Terigu', 'Jumlah': '5 gr', 'Energi (kkal)': '16.65', 'KH (g)': '3.86', 'Protein (g)': '0.45', 'Lemak (g)': '0.05', 'Zat Besi (mg)': '0.07'},
            {'Bahan': 'Tepung Tapioka', 'Jumlah': '10 gr', 'Energi (kkal)': '36', 'KH (g)': '8.9', 'Protein (g)': '0', 'Lemak (g)': '0', 'Zat Besi (mg)': '0'},
            {'Bahan': 'Telur Ayam', 'Jumlah': '15 gr', 'Energi (kkal)': '23.1', 'KH (g)': '0.11', 'Protein (g)': '1.86', 'Lemak (g)': '1.62', 'Zat Besi (mg)': '0.45'},
            {'Bahan': 'Daun Bawang', 'Jumlah': '15 gr', 'Energi (kkal)': '6.15', 'KH (g)': '1.17', 'Protein (g)': '0.3', 'Lemak (g)': '0.05', 'Zat Besi (mg)': '0.35'},
            {'Bahan': 'Bawang Putih', 'Jumlah': '4 gr', 'Energi (kkal)': '4.48', 'KH (g)': '0.92', 'Protein (g)': '0.18', 'Lemak (g)': '0.01', 'Zat Besi (mg)': '0.04'},
            {'Bahan': 'Bawang Merah', 'Jumlah': '5 gr', 'Energi (kkal)': '2.3', 'KH (g)': '0.46', 'Protein (g)': '0.08', 'Lemak (g)': '0.02', 'Zat Besi (mg)': '0.04'},
            {'Bahan': 'Gula', 'Jumlah': '1 gr', 'Energi (kkal)': '3.94', 'KH (g)': '0.94', 'Protein (g)': '0', 'Lemak (g)': '0', 'Zat Besi (mg)': '0'},
            {'Bahan': 'Garam', 'Jumlah': '1 gr', 'Energi (kkal)': '0', 'KH (g)': '0', 'Protein (g)': '0', 'Lemak (g)': '0', 'Zat Besi (mg)': '0'},
            {'Bahan': 'Kaldu Jamur', 'Jumlah': '1 gr', 'Energi (kkal)': '0', 'KH (g)': '0', 'Protein (g)': '0', 'Lemak (g)': '0', 'Zat Besi (mg)': '0'},
            {'Bahan': 'Merica', 'Jumlah': '0.5 gr', 'Energi (kkal)': '0.05', 'KH (g)': '0.01', 'Protein (g)': '0', 'Lemak (g)': '0', 'Zat Besi (mg)': '0'},
            {'Bahan': 'TOTAL', 'Jumlah': '133.5 gr', 'Energi (kkal)': '266.37', 'KH (g)': '42.7', 'Protein (g)': '13.81', 'Lemak (g)': '5.11', 'Zat Besi (mg)': '2.75'},
          ],
        ),
        TutorialSection(
          title: 'Persentase Angka Kecukupan Gizi (%AKG)',
          type: SectionType.summary,
          summaryData: {
            'Energi Total': '266.37 kkal (11.8% AKG)',
            'Karbohidrat Total': '42.7 gr (11.9% AKG)',
            'Protein Total': '13.81 gr (23.0% AKG - Tinggi Protein)',
            'Lemak Total': '5.11 gr (7.9% AKG)',
            'Zat Besi Total': '2.75 mg (15.3% AKG)',
          },
        ),
      ],
    ),
    const TutorialDetailData(
      title: '4. Jumlah Sajian',
      categoryName: 'Nugget SIJAGO',
      imagePath: 'assets/images/nugget_sijago.png',
      sections: [
        TutorialSection(
          title: 'Informasi Nilai Gizi Kemasan',
          type: SectionType.summary,
          summaryData: {
            'Takaran Saji': '100 gr',
            'Jumlah Sajian Per Kemasan': '4 Sajian per Kemasan',
            'Energi Total Per Sajian': '266.37 kkal',
            'Lemak Total': '5.11 gr (7.9% AKG)',
            'Protein': '13.81 gr (23% AKG)',
            'Karbohidrat Total': '42.7 gr (11.9% AKG)',
            'Zat Besi': '2.75 mg (15.3% AKG)',
          },
        ),
        TutorialSection(
          title: 'Catatan AKG',
          type: SectionType.list,
          items: [
            '*Persen AKG berdasarkan kebutuhan energi 2250 kkal. Kebutuhan energi Anda mungkin lebih tinggi atau lebih rendah.',
          ],
        ),
      ],
    ),
  ];

  // ─── PHBS ─────────────────────────────────────────────────────────────────
  static final List<TutorialDetailData> _phbsModules = [
    const TutorialDetailData(
      title: '1. 10 Indikator Perilaku Hidup Bersih & Sehat (PHBS)',
      categoryName: 'PHBS',
      imagePath: 'assets/images/cat_phbs.png',
      sections: [
        TutorialSection(
          title: '10 Indikator Utama PHBS Rumah Tangga',
          type: SectionType.list,
          items: [
            '1. Persalinan ditolong oleh tenaga kesehatan',
            '2. Memberi ASI eksklusif pada bayi umur 0-6 bulan',
            '3. Menimbang balita setiap bulan di Posyandu',
            '4. Menggunakan air bersih untuk kebutuhan sehari-hari',
            '5. Mencuci tangan dengan air bersih dan sabun',
            '6. Menggunakan jamban sehat',
            '7. Memberantas jentik nyamuk di rumah seminggu sekali',
            '8. Makan buah dan sayur setiap hari',
            '9. Melakukan aktivitas fisik setiap hari minimal 30 menit',
            '10. Tidak merokok di dalam rumah',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '2. 6 Langkah Cuci Tangan',
      categoryName: 'PHBS',
      imagePath: 'assets/images/cat_phbs.png',
      sections: [
        TutorialSection(
          title: '6 Langkah Cuci Tangan Pakai Sabun (WHO)',
          type: SectionType.steps,
          items: [
            'Gosok sabun pada kedua telapak tangan.',
            'Gosok kedua punggung tangan secara bergantian.',
            'Gosok sela-sela jari tangan hingga bersih.',
            'Bersihkan ujung-ujung jari dengan posisi mengunci.',
            'Gosok dan putar kedua ibu jari secara bergantian.',
            'Gosok telapak tangan dengan ujung jari, lalu bilas dengan air bersih mengalir.',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '3. Tips Pembuatan Oralit',
      categoryName: 'PHBS',
      imagePath: 'assets/images/cat_phbs.png',
      sections: [
        TutorialSection(
          title: 'Langkah Pertolongan Pertama Diare (Oralit)',
          type: SectionType.steps,
          items: [
            'Siapkan air yang telah dimasak sebanyak 1 gelas (200 ml).',
            'Siapkan gula 1 sendok teh penuh.',
            'Siapkan garam ¼ sendok teh.',
            'Campurkan air, gula, dan garam ke dalam gelas, lalu aduk hingga larut sempurna.',
          ],
        ),
      ],
    ),
  ];

  // ─── SILOKA (EKRAF) ───────────────────────────────────────────────────────
  static final List<TutorialDetailData> _silokaModules = [
    const TutorialDetailData(
      title: '1. Formulasi & Komposisi Kopi SILOKA',
      categoryName: 'SILOKA',
      imagePath: 'assets/images/kopi_siloka.png',
      sections: [
        TutorialSection(
          title: 'Komposisi Produk Kopi SILOKA',
          type: SectionType.list,
          items: [
            'Biji Kopi Robusta khas Desa Gunungsari (Petik Merah)',
            'Jahe Merah Kering Pilihan',
            'Batang Sereh Sangrai Halus',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '2. Tahapan Pemrosesan & Roasting',
      categoryName: 'SILOKA',
      imagePath: 'assets/images/kopi_siloka.png',
      sections: [
        TutorialSection(
          title: 'Langkah Pemrosesan Kopi SILOKA',
          type: SectionType.steps,
          items: [
            'Sortasi biji kopi hijau (green beans) hasil panen petik merah.',
            'Sangrai (roasting) biji kopi pada tingkat medium-dark roast.',
            'Pencampuran bubuk rempah jahe dan sereh dengan rasio terukur.',
            'Proses resting selama 4-7 hari agar aroma dan rasa rempah menyatu sempurna.',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '3. Panduan Penyeduhan & Rasio',
      categoryName: 'SILOKA',
      imagePath: 'assets/images/kopi_siloka.png',
      sections: [
        TutorialSection(
          title: 'Cara Menyeduh Kopi SILOKA',
          type: SectionType.steps,
          items: [
            'Siapkan 10 gr bubuk Kopi SILOKA ke dalam cangkir.',
            'Tuangkan 150-200 ml air panas dengan suhu ideal 90-95°C.',
            'Aduk perlahan dan diamkan selama 2-3 menit hingga ekstraksi sempurna.',
            'Kopi SILOKA hangat siap dinikmati.',
          ],
        ),
      ],
    ),
    const TutorialDetailData(
      title: '4. Strategi Pemasaran UMKM',
      categoryName: 'SILOKA',
      imagePath: 'assets/images/kopi_siloka.png',
      sections: [
        TutorialSection(
          title: 'Kanal & Media Pemasaran',
          type: SectionType.list,
          items: [
            'Penjualan offline di BUMDes & Kedai Lokal Desa Gunungsari',
            'Pemasaran online via Marketplace & WhatsApp Business',
            'Promosi kemasan standing pouch berkatup udara khas Desa Gunungsari',
          ],
        ),
      ],
    ),
  ];

  // ─── BIOPORI ──────────────────────────────────────────────────────────────
  static final List<TutorialDetailData> _bioporiModules = [
    const TutorialDetailData(
      title: '1. Panduan Lubang Resapan Biopori',
      categoryName: 'Biopori',
      imagePath: 'assets/images/cat_biopori.png',
      sections: [
        TutorialSection(
          title: 'Alat dan Bahan Biopori',
          type: SectionType.list,
          items: [
            'Bor tanah / Linggis',
            'Pipa PVC diameter 10 cm (panjang 80-100 cm) berlubang',
            'Penutup pipa PVC berlubang',
            'Sampah organik dapur / dedaunan',
          ],
        ),
        TutorialSection(
          title: 'Langkah Pembuatan Lubang Biopori',
          type: SectionType.steps,
          items: [
            'Buat lubang tegak lurus di tanah dengan kedalaman 80-100 cm.',
            'Masukan pipa PVC berlubang ke dalam tanah.',
            'Isi pipa dengan sampah organik hingga penuh.',
            'Tutup pipa dengan penutup berlubang agar air hujan tetap masuk.',
          ],
        ),
      ],
    ),
  ];

  // ─── ALAT PEMBAKAR SAMPAH ─────────────────────────────────────────────────
  static final List<TutorialDetailData> _alatPembakarModules = [
    const TutorialDetailData(
      title: '1. Alat Pembakar Sampah Minim Asap',
      categoryName: 'Alat Pembakar Sampah',
      imagePath: 'assets/images/cat_alat_pembakar.png',
      sections: [
        TutorialSection(
          title: 'Komponen Utama',
          type: SectionType.list,
          items: [
            'Drum besi bekas bermulut rapat',
            'Cerobong asap dengan saringan air / sistem jet air sederhana',
            'Tungku bakar bawah berpori sirkulasi udara',
          ],
        ),
        TutorialSection(
          title: 'Cara Pengoperasian',
          type: SectionType.steps,
          items: [
            'Pilahkan sampah anorganik kering (kertas, plastik keras).',
            'Masukkan sampah ke dalam drum pembakar.',
            'Nyalakan pemantik dari pintu tungku bawah.',
            'Tutup cerobong minim asap agar pembakaran suhu tinggi berjalan efisien.',
          ],
        ),
      ],
    ),
  ];

  // ─── KOMPOS KOTORAN HEWAN ─────────────────────────────────────────────────
  static final List<TutorialDetailData> _komposModules = [
    const TutorialDetailData(
      title: '1. Pembuatan Kompos Kotoran Hewan (EM4)',
      categoryName: 'Kompos Kotoran Hewan',
      imagePath: 'assets/images/cat_kompos.png',
      sections: [
        TutorialSection(
          title: 'Bahan Pembuatan Kompos',
          type: SectionType.list,
          items: [
            'Kotoran ternak (sapi/kambing) 100 kg',
            'Dedaunan kering / sekam 20 kg',
            'Bioaktivator EM4 100 ml',
            'Gula pasir / molase 100 gr',
            'Air secukupnya',
          ],
        ),
        TutorialSection(
          title: 'Tahapan Pembuatan',
          type: SectionType.steps,
          items: [
            'Campurkan kotoran ternak dan dedaunan kering hingga rata.',
            'Larutkan EM4 dan gula pasir ke dalam air.',
            'Siramkan larutan EM4 ke tumpukan bahan hingga kelembaban 40-50%.',
            'Tutup tumpukan dengan terpal dan fermentasi selama 14-21 hari sambil dibolak-balik seminggu sekali.',
          ],
        ),
      ],
    ),
  ];

  // ─── KEBUN GIZI ───────────────────────────────────────────────────────────
  static final List<TutorialDetailData> _kebunGiziModules = [
    const TutorialDetailData(
      title: '1. Panduan Kebun Gizi Keluarga',
      categoryName: 'Kebun Gizi',
      imagePath: 'assets/images/cat_kebun_gizi.png',
      sections: [
        TutorialSection(
          title: 'Tanaman Kebun Gizi Pencegah Stunting',
          type: SectionType.list,
          items: [
            'Tanaman Kelor (Kaya Zat Besi & Protein)',
            'Tanaman Bayam & Kangkung (Sumber Mineral & Serat)',
            'Tanaman Jagung Manis & Ubi Kayu (Karbohidrat Lokal)',
            'Tanaman Cabai, Tomat & Terung (Vitamin C & A)',
          ],
        ),
        TutorialSection(
          title: 'Langkah Penanaman Pekarangan',
          type: SectionType.steps,
          items: [
            'Siapkan polybag atau bedengan tanah ukuran 1x2 meter.',
            'Campurkan tanah humus dan pupuk kompos kotoran hewan (1:1).',
            'Tanam bibit sayur gizi dan siram 2 kali sehari.',
            'Manfaatkan hasil panen kebun gizi untuk pemenuhan gizi keluarga sehari-hari.',
          ],
        ),
      ],
    ),
  ];

  // ─── DEFAULT FALLBACK ─────────────────────────────────────────────────────
  static List<TutorialDetailData> _defaultModules(String categoryName) {
    return [
      TutorialDetailData(
        title: '1. Panduan $categoryName',
        categoryName: categoryName,
        sections: [
          TutorialSection(
            title: 'Informasi Modul $categoryName',
            type: SectionType.list,
            items: [
              'Panduan edukasi terpadu Desa Gunungsari.',
              'Materi pendukung program kesehatan & lingkungan.',
            ],
          ),
        ],
      ),
      TutorialDetailData(
        title: '2. Cara Pelaksanaan',
        categoryName: categoryName,
        sections: [
          const TutorialSection(
            title: 'Langkah-Langkah',
            type: SectionType.steps,
            items: [
              'Persiapan materi dan bahan.',
              'Pelaksanaan kegiatan bersama masyarakat.',
              'Evaluasi dan pemeliharaan berkesinambungan.',
            ],
          ),
        ],
      ),
    ];
  }
}
