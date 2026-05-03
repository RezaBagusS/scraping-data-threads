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
    
    # Inisialisasi file data (Dikosongkan hanya sekali di awal)
    Create Directory    data
    Create File    data/raw_data_umkm.txt    content=${EMPTY}

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
    Log To Console    \n[STEP] Mencari topik: ${keyword}
    Go To    https://www.threads.com/search?q=${encoded_keyword}
    Sleep    5s

Scroll Down And Collect Data
    [Arguments]    ${scroll_count}=3
    Log To Console    [STEP] Melakukan scrolling untuk memuat data [${scroll_count} kali]...
    FOR    ${i}    IN RANGE    ${scroll_count}
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
        Sleep    3s
    END

Extract Threads Post Data
    [Documentation]    Mengambil teks dari postingan (Metode Append agar tidak menimpa data sebelumnya).
    Log To Console    [STEP] Mengekstraksi data postingan...
    ${elements}=    Get WebElements    xpath=//div[@data-pressable-container="true"]//span[@dir="auto"]
    
    ${count}=    Set Variable    0
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${length}=    Get Length    ${text}
        IF    $text and $length > 15
            # Menggunakan Append agar data terkumpul dari semua keyword
            Append To File    data/raw_data_umkm.txt    ${text}\n---\n
            ${count}=    Evaluate    ${count} + 1
        END
    END
    Log To Console    [RESULT] Berhasil menambah ${count} baris data mentah.

Format Data To CSV
    [Documentation]    Mengonversi raw_data.txt menjadi threads_data.csv yang rapi.
    Log To Console    \n[STEP] Merapikan seluruh hasil pencarian ke format CSV...
    ${content}=    Get File    data/raw_data_umkm.txt
    @{posts}=      Split String    ${content}    ---
    
    Create File    data/threads_umkm_data.csv    content=Post_Content\n
    
    ${csv_count}=    Set Variable    0
    FOR    ${post}    IN    @{posts}
        ${cleaned_post}=    Strip String    ${post}
        IF    $cleaned_post
            ${flat_post}=    Replace String    ${cleaned_post}    \n    ${SPACE}
            ${flat_post}=    Replace String    ${flat_post}    "    '
            ${flat_post}=    Replace String    ${flat_post}    ,    ${SPACE}
            Append To File    data/threads_umkm_data.csv    "${flat_post}"\n
            ${csv_count}=    Evaluate    ${csv_count} + 1
        END
    END
    Log To Console    [RESULT] SUCCESS: Total ${csv_count} postingan dari semua topik disimpan ke CSV.

Close Browser Session
    Log To Console    [INFO] Selesai.
    Close All Browsers
