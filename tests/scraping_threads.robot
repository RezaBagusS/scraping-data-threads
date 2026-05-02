*** Settings ***
Documentation    Otomasi scraping data dari Threads.net menggunakan SeleniumLibrary.
Resource         ../resources/keywords.resource

*** Variables ***
${URL_THREADS}    https://www.threads.net
${SEARCH_TOPIC}   teknologi AI

*** Test Cases ***
Scrape Threads By Topic
    [Documentation]    Mencari dan mengumpulkan data postingan dari Threads.
    Setup Browser    ${URL_THREADS}
    Wait Until Page Contains Element    xpath=//main    timeout=10s
    Log    Halaman Threads berhasil dibuka.
    # Langkah selanjutnya: Pencarian topik (Fase 2-3)
    [Teardown]    Close Browser Session
