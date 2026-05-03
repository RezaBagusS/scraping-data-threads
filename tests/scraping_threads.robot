*** Settings ***
Documentation    Otomasi Pengumpulan Data Threads - Multi-Keyword Scraping.
Resource         ../resources/keywords.resource

*** Variables ***
# Daftar kata kunci riset UMKM
@{KEYWORDS}      UMKM    kendala bisnis    modal usaha    masalah UMKM    solusi dagang

*** Test Cases ***
Execute Multi-Keyword Scraping
    [Documentation]    Menjalankan pencarian untuk banyak kata kunci sekaligus.
    Setup Browser    https://www.threads.com
    
    Login To Threads
    
    # Loop untuk setiap kata kunci
    FOR    ${keyword}    IN    @{KEYWORDS}
        Search Threads For Topic    ${keyword}
        Scroll Down And Collect Data    scroll_count=3
        Extract Threads Post Data
    END
    
    # Setelah semua selesai, rapikan ke CSV
    Format Data To CSV
    
    [Teardown]    Close Browser Session
