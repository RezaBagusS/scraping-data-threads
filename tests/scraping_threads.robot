*** Settings ***
Documentation    Otomasi pengumpulan data kendala UMKM dari Threads (Fase 2 & 3).
Resource         ../resources/keywords.resource

*** Variables ***
${BROWSER}        headlesschrome
${TOPIC}          kendala bisnis UMKM

*** Test Cases ***
Execute Full Scraping For UMKM Research
    [Documentation]    Menjalankan proses lengkap: Login, Navigasi, dan Ekstraksi Data.
    Setup Browser    https://www.threads.net    browser=${BROWSER}
    
    # Fase 2: Otentikasi
    Login To Threads
    
    # Fase 2: Navigasi
    Search Threads For Topic    ${TOPIC}
    
    # Fase 3: Ekstraksi Data (Core)
    Log    Memulai proses pengambilan data...
    Scroll Down And Collect Data    scroll_count=3
    Extract Threads Post Data
    
    Log    Data berhasil dikumpulkan di folder data/
    [Teardown]    Close Browser Session
