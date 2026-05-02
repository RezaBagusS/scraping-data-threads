# 📍 Roadmap: Threads Scraper Automation

Dokumen ini merinci langkah-langkah pengembangan sistem otomasi pengumpulan data dari Threads menggunakan **Robot Framework**.

## 🚀 Fase 1: Inisialisasi & Lingkungan Kerja
- [x] Setup lingkungan Python dan Virtual Environment.
- [x] Instalasi Robot Framework dan library pendukung (`robotframework-seleniumlibrary`).
- [x] Konfigurasi Driver (Selenium Manager/Chromedriver).
- [x] Pembuatan struktur folder project (tests, resources, results, data).

## 🔐 Fase 2: Otentikasi & Navigasi
- [x] Implementasi flow login Threads (Instagram Login).
- [x] Penanganan verifikasi dua langkah (Integrasi manual/Wait).
- [x] Manajemen session/cookies (Implementasi awal via .env).
- [x] Pembuatan keyword untuk navigasi ke halaman pencarian atau topik spesifik.

## 🔍 Fase 3: Ekstraksi Data (Core)
- [x] Pengembangan script untuk mencari keyword/topik tertentu.
- [x] Implementasi *infinite scroll* untuk memuat lebih banyak post.
- [x] Ekstraksi elemen data (Username & Konten teks).
- [ ] Ekstraksi elemen data tambahan (Timestamp, Likes, Replies).
- [ ] Penanganan elemen dinamis (Skeleton screens/Lazy loading).

## 💾 Fase 4: Manajemen Data & Output
- [ ] Integrasi library untuk penyimpanan data (CSV, JSON, atau Excel).
- [ ] Pembersihan data (cleaning) dasar saat proses scraping.
- [ ] Organisasi file output berdasarkan timestamp atau topik.

## 🛠️ Fase 5: Optimasi & Error Handling
- [x] Implementasi *Wait strategies* yang efisien (Wait Until Page Contains).
- [ ] Error handling untuk elemen yang tidak ditemukan atau timeout.
- [x] Penyesuaian *Human-like behavior* (User-Agent kustom & Random Delay).
- [x] Konfigurasi headless mode untuk eksekusi yang lebih ringan.

## 📊 Fase 6: Reporting & Penunjang
- [x] Kustomisasi Robot Framework Report & Log (Default output aktif).
- [x] Dokumentasi akhir penggunaan script (README updated).
- [ ] (Optional) Integrasi dengan dashboard visualisasi data sederhana.
