*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections

*** Keywords ***
Setup Browser
    [Arguments]    ${url}    ${browser}=chrome
    Log To Console    \n[STEP] Membuka browser Chrome...
    Open Browser    ${url}    ${browser}
    Set Window Size    1280    900
    Set Selenium Speed    0.2 seconds

Login To Threads
    [Documentation]    Melakukan login otomatis menggunakan metode tekan ENTER.
    Log To Console    [STEP] Mencoba login ke Threads...
    Go To    https://www.threads.com/login
    Wait Until Page Contains Element    xpath=//input[@autocomplete='username']    timeout=20s
    Input Text      xpath=//input[@autocomplete='username']    %{THREADS_USERNAME}
    Input Password  xpath=//input[@autocomplete='current-password']    %{THREADS_PASSWORD}
    Press Keys      xpath=//input[@autocomplete='current-password']    ENTER
    
    # Validasi login
    Log To Console    [STEP] Menunggu dashboard dimuat...
    Wait Until Page Contains    For you    timeout=45s
    Log To Console    [RESULT] SUCCESS: Login berhasil!

Search Threads For Topic
    [Arguments]    ${keyword}
    ${encoded_keyword}=    Replace String    ${keyword}    ${SPACE}    %20
    Log To Console    [STEP] Mencari topik: ${keyword}
    Go To    https://www.threads.com/search?q=${encoded_keyword}
    Sleep    5s

Scroll Down And Collect Data
    [Arguments]    ${scroll_count}=3
    Log To Console    [STEP] Melakukan scrolling untuk memuat data...
    FOR    ${i}    IN RANGE    ${scroll_count}
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
        Sleep    3s
        Log To Console    ... Scroll ke-${i+1} selesai.
    END

Extract Threads Post Data
    [Documentation]    Mengambil teks dari postingan yang muncul di layar.
    Log To Console    [STEP] Mengekstraksi data postingan...
    ${elements}=    Get WebElements    xpath=//div[@data-pressable-container="true"]//span[@dir="auto"]
    
    Create Directory    data
    Create File    data/raw_data_umkm.txt    content=${EMPTY}
    
    ${count}=    Set Variable    0
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${length}=    Get Length    ${text}
        # Filter teks pendek
        IF    ${length} > 15
            Append To File    data/raw_data_umkm.txt    ${text}\n---\n
            ${count}=    Evaluate    ${count} + 1
        END
    END
    Log To Console    [RESULT] ${count} baris data mentah berhasil diambil.

Format Data To CSV
    [Documentation]    Mengonversi raw_data.txt menjadi threads_data.csv yang rapi.
    Log To Console    [STEP] Merapikan data ke format CSV...
    ${content}=    Get File    data/raw_data_umkm.txt
    @{posts}=      Split String    ${content}    ---
    
    Create File    data/threads_umkm_data.csv    content=Post_Content\n
    
    ${csv_count}=    Set Variable    0
    FOR    ${post}    IN    @{posts}
        ${cleaned_post}=    Strip String    ${post}
        # PERBAIKAN: Menggunakan Python 'truthy' check (IF $cleaned_post)
        IF    $cleaned_post
            # Bersihkan karakter yang merusak CSV
            ${flat_post}=    Replace String    ${cleaned_post}    \n    ${SPACE}
            ${flat_post}=    Replace String    ${flat_post}    "    '
            ${flat_post}=    Replace String    ${flat_post}    ,    ${SPACE}
            Append To File    data/threads_umkm_data.csv    "${flat_post}"\n
            ${csv_count}=    Evaluate    ${csv_count} + 1
        END
    END
    Log To Console    [RESULT] SUCCESS: ${csv_count} postingan berhasil disimpan ke CSV.

Close Browser Session
    Log To Console    [INFO] Selesai.
    Close All Browsers
