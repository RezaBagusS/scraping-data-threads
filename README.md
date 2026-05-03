# 🧵 Threads Scraper for UMKM Research

Bot otomasi menggunakan **Robot Framework** untuk mengumpulkan data kualitatif dari Threads.net mengenai kendala, tips, dan aktivitas bisnis UMKM.

## 🚀 Fitur Utama
- **Automated Login**: Login otomatis menggunakan kredensial dari file `.env`.
- **Multi-Keyword Search**: Mendukung pencarian banyak kata kunci sekaligus (contoh: "UMKM", "kendala bisnis", "modal usaha").
- **Infinite Scrolling**: Menggulir halaman secara otomatis untuk memuat lebih banyak data.
- **Data Cleaning**: Menghapus baris kosong, meratakan baris baru, dan membersihkan karakter khusus agar aman untuk CSV.
- **Structured Output**: Menyimpan hasil gabungan semua kata kunci ke dalam **CSV** (`data/threads_umkm_data.csv`).

## 🛠️ Prasyarat
1. **Python 3.x** terinstal.
2. **Google Chrome** terinstal.
3. Kredensial Threads sudah diatur di file `.env`:
   ```env
   THREADS_USERNAME=username_anda
   THREADS_PASSWORD=password_anda
   ```

## 📦 Instalasi
```bash
# Masuk ke folder project
cd scraping-data

# Buat & Aktifkan Virtual Environment
python3 -m venv venv
source venv/bin/activate

# Instal Library
pip install robotframework-seleniumlibrary
```

## 🏃 Cara Menjalankan
Pastikan Chrome dalam keadaan tertutup (Force Quit) agar tidak terjadi konflik sesi, lalu jalankan:
```bash
source venv/bin/activate
export $(grep -v '^#' .env | xargs)
robot -d results tests/scraping_threads.robot
```

## 📊 Konfigurasi Kata Kunci
Anda dapat mengubah daftar kata kunci pencarian di file `tests/scraping_threads.robot` pada bagian `@{KEYWORDS}`.

## ⚖️ Disclaimer
Gunakan bot ini dengan bijak dan patuhi kebijakan privasi serta ketentuan penggunaan Threads.net. Bot ini dibuat untuk tujuan riset akademis/pengembangan produk.
