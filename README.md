# 🧵 Threads Data Scraper Automation

Proyek ini bertujuan untuk mengumpulkan data dari platform **Threads.net** secara otomatis menggunakan **Robot Framework**. Otomasi ini difokuskan pada pengumpulan data terkait kendala UMKM untuk riset pengembangan produk.

## 🛠️ Tech Stack
- **Language:** Python 3.x
- **Framework:** [Robot Framework](https://robotframework.org/)
- **Library:** [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/)
- **Driver Management:** [Webdriver-manager](https://pypi.org/project/webdriver-manager/)
- **Reporting:** Built-in Robot Framework HTML reports

## 📋 Fitur Utama
- **Login Automation:** Melakukan login otomatis ke Threads menggunakan kredensial Instagram.
- **Topik-Based Search:** Mencari postingan berdasarkan keyword tertentu (misal: "kendala UMKM").
- **Infinite Scrolling:** Menggulir halaman secara otomatis untuk mengambil data dalam jumlah banyak.
- **Human-Like Behavior:** Menggunakan User-Agent kustom dan jeda waktu acak untuk meminimalisir deteksi bot.

## ⚙️ Persyaratan Sistem
1. Python 3.9 atau versi terbaru.
2. Google Chrome terinstal di sistem.

## 🚀 Cara Instalasi

1. Masuk ke folder project:
   ```bash
   cd scraping-data
   ```

2. Buat dan aktifkan virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Mac/Linux
   # atau
   venv\Scripts\activate     # Windows
   ```

3. Instal dependensi:
   ```bash
   pip install -r requirements.txt
   ```

4. Konfigurasi Kredensial:
   Buat file `.env` di root folder dan isi dengan akun Instagram/Threads Anda:
   ```env
   THREADS_USERNAME=username_anda
   THREADS_PASSWORD=password_anda
   ```

## 🖥️ Cara Menjalankan
Untuk menjalankan proses scraping dengan memuat variabel dari `.env`:

```bash
# Mac/Linux
export $(grep -v '^#' .env | xargs) && robot -d results tests/scraping_threads.robot

# Windows (PowerShell)
# Silakan isi variabel lingkungan secara manual atau gunakan library dotenv
robot -d results tests/scraping_threads.robot
```

## 📂 Struktur Folder
```text
scraping-data/
├── tests/              # Skrip utama (.robot)
├── resources/          # Keyword kustom dan logika Selenium
├── data/               # Hasil output scraping (txt/csv)
├── results/            # Log dan laporan Robot Framework
├── ROADMAP.md          # Rencana pengembangan project
└── README.md           # Dokumentasi utama
```

## ⚠️ Disclaimer
Project ini dibuat untuk tujuan edukasi dan riset. Pengguna bertanggung jawab penuh atas kepatuhan terhadap *Terms of Service* dari Threads/Meta terkait scraping data. Gunakan akun dummy untuk menghindari risiko pembatasan akun.
