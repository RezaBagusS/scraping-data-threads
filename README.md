# 🧵 Threads Data Scraper Automation

Proyek ini bertujuan untuk mengumpulkan data dari platform **Threads.net** secara otomatis menggunakan **Robot Framework**. Otomasi ini difokuskan pada pengumpulan postingan berdasarkan topik atau masalah tertentu untuk kebutuhan analisis data.

## 🛠️ Tech Stack
- **Language:** Python 3.x
- **Framework:** [Robot Framework](https://robotframework.org/)
- **Library:** [Browser Library](https://marketsquare.github.io/robotframework-browser/) (Playwright based)
- **Reporting:** Built-in Robot Framework HTML reports

## 📋 Fitur Utama
- **Topik-Based Search:** Mencari postingan berdasarkan keyword tertentu.
- **Auto Scrolling:** Mengambil data dalam jumlah banyak dengan scroll otomatis.
- **Data Extraction:** Mengambil username, teks postingan, waktu, dan interaksi.
- **Export Data:** Menyimpan hasil scraping ke format CSV/JSON.

## ⚙️ Persyaratan Sistem
1. Python 3.8 atau versi terbaru.
2. Node.js (diperlukan untuk Playwright/Browser Library).

## 🚀 Cara Instalasi

1. Clone repositori ini atau masuk ke folder project:
   ```bash
   cd scraping-data
   ```

2. Buat virtual environment (disarankan):
   ```bash
   python -m venv venv
   source venv/bin/activate  # Untuk Mac/Linux
   ```

3. Instal library yang diperlukan:
   ```bash
   pip install robotframework-browser
   rfbrowser init
   ```

## 🖥️ Cara Menjalankan
Untuk menjalankan proses scraping, gunakan perintah berikut:

```bash
robot -d results tests/scraping_threads.robot
```

> **Catatan:** Pastikan Anda telah mengonfigurasi kredensial login dan keyword target di dalam file variabel atau file `.robot`.

## 📂 Struktur Folder
```text
scraping-data/
├── tests/              # Berisi file .robot (test cases)
├── resources/          # Keyword kustom dan variabel
├── data/               # Hasil output scraping (CSV/JSON)
├── results/            # Log dan laporan Robot Framework
├── roadmap.md          # Rencana pengembangan project
└── readme.md           # Dokumentasi utama
```

## ⚠️ Disclaimer
Project ini dibuat untuk tujuan edukasi dan riset. Pengguna bertanggung jawab penuh atas kepatuhan terhadap *Terms of Service* dari Threads/Meta terkait scraping data.
