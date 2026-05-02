*** Settings ***
Documentation    Otomasi scraping data dari Threads.net berdasarkan topik.
Library          Browser
Resource         ../resources/keywords.resource

*** Variables ***
${URL_THREADS}    https://www.threads.net
${BROWSER}        chromium
${HEADLESS}       False
${SEARCH_TOPIC}   teknologi AI  # Ganti dengan topik yang diinginkan

*** Test Cases ***
Scrape Threads By Topic
    [Documentation]    Mencari dan mengumpulkan data postingan dari Threads.
    Open Threads Home
    Search For Topic    ${SEARCH_TOPIC}
    Scroll And Collect Data    limit=50
    Save Data To CSV
    [Teardown]    Close Browser

*** Keywords ***
Open Threads Home
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${URL_THREADS}
    # Tunggu login atau handle guest view
    Wait For Elements State    text="Log in"    visible    timeout=10s

Search For Topic
    [Arguments]    ${topic}
    Log    Searching for: ${topic}
    # Logika navigasi ke pencarian dan input keyword
    # Click    selector_search_icon
    # Fill Text    selector_search_input    ${topic}
    # Press Keys    selector_search_input    Enter

Scroll And Collect Data
    [Arguments]    ${limit}
    Log    Scrolling to collect ${limit} posts...
    # Implementasi infinite scroll dan pengambilan data selectors

Save Data To CSV
    Log    Saving data to data/results.csv
