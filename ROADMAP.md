# 📍 Roadmap: Threads Scraper Automation

Dokumen ini merinci langkah-langkah pengembangan sistem otomasi pengumpulan data dari Threads menggunakan **Robot Framework**.

## 🚀 Fase 1: Inisialisasi & Lingkungan Kerja
- [x] Setup lingkungan Python dan Virtual Environment.
- [x] Instalasi Robot Framework dan library pendukung (`robotframework-seleniumlibrary`).
- [x] Konfigurasi Driver (Selenium Manager/Chromedriver).
- [x] Pembuatan struktur folder project (tests, resources, results, data).

## 🔐 Fase 2: Otentikasi & Navigasi
- [ ] Implementasi flow login Threads (Instagram Login).
- [ ] Penanganan verifikasi dua langkah (jika diperlukan).
- [ ] Manajemen session/cookies untuk menghindari login berulang.
- [ ] Pembuatan keyword untuk navigasi ke halaman pencarian atau topik spesifik.

## 🔍 Fase 3: Ekstraksi Data (Core)
- [ ] Pengembangan script untuk mencari keyword/topik tertentu.
- [ ] Implementasi *infinite scroll* untuk memuat lebih banyak post.
- [ ] Ekstraksi elemen data:
    - Username & Profile link.
    - Konten teks (Post).
    - Timestamp.
    - Jumlah likes/replies.
- [ ] Penanganan elemen dinamis (Skeleton screens/Lazy loading).

## 💾 Fase 4: Manajemen Data & Output
- [ ] Integrasi library untuk penyimpanan data (CSV, JSON, atau Excel).
- [ ] Pembersihan data (cleaning) dasar saat proses scraping.
- [ ] Organisasi file output berdasarkan timestamp atau topik.

## 🛠️ Fase 5: Optimasi & Error Handling
- [ ] Implementasi *Wait strategies* yang efisien untuk menghindari deteksi bot.
- [ ] Error handling untuk elemen yang tidak ditemukan atau timeout.
- [ ] Penyesuaian *Human-like behavior* (delay random, mouse movement).
- [ ] Konfigurasi headless mode untuk eksekusi yang lebih ringan.

## 📊 Fase 6: Reporting & Penunjang
- [ ] Kustomisasi Robot Framework Report & Log.
- [ ] Dokumentasi akhir penggunaan script.
- [ ] (Optional) Integrasi dengan dashboard visualisasi data sederhana.
