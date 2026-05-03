*** Settings ***
Documentation    Otomasi Pengumpulan Data Threads - Fase 3 & 4.
Resource         ../resources/keywords.resource

*** Variables ***
${TOPIC}         UMKM

*** Test Cases ***
Execute Full Scraping And Data Management
    [Documentation]    Alur lengkap: Login -> Cari -> Scrape -> Simpan ke CSV.
    Setup Browser    https://www.threads.com
    
    Login To Threads
    
    Search Threads For Topic    ${TOPIC}
    
    # Scroll lebih banyak untuk data yang lebih kaya
    Scroll Down And Collect Data    scroll_count=5
    
    Extract Threads Post Data
    
    Format Data To CSV
    
    [Teardown]    Close Browser Session
