*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections

*** Variables ***
${CHROME_OPTIONS}    add_argument("--disable-notifications"); add_argument("--start-maximized")

*** Keywords ***
Setup Browser
    [Arguments]    ${url}    ${browser}=chrome
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    # Menggunakan User-Agent asli agar tidak cepat diblokir
    Call Method    ${options}    add_argument    --user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36
    Open Browser    ${url}    ${browser}    options=${options}
    Set Selenium Speed    0.3 seconds
    Set Window Size    1280    900

Login To Threads
    [Documentation]    Melakukan login ke Threads.
    Go To    https://www.threads.net/login
    Wait Until Page Contains Element    xpath=//input[@name='username']    timeout=20s
    Input Text      xpath=//input[@name='username']    %{THREADS_USERNAME}
    Input Password  xpath=//input[@name='password']    %{THREADS_PASSWORD}
    Click Element   xpath=//button[@type='submit']
    Sleep    10s
    Wait Until Page Contains Element    xpath=//main    timeout=30s

Search Threads For Topic
    [Arguments]    ${keyword}
    ${encoded_keyword}=    Replace String    ${keyword}    ${SPACE}    %20
    Go To    https://www.threads.net/search?q=${encoded_keyword}
    Log    Mencari topik: ${keyword}
    Sleep    5s
    # Scroll sedikit untuk memicu loading data
    Execute Javascript    window.scrollTo(0, 500)
    Sleep    2s

Scroll Down And Collect Data
    [Arguments]    ${scroll_count}=5
    [Documentation]    Melakukan scroll ke bawah dan mengumpulkan data postingan.
    ${all_data}=    Create List
    
    FOR    ${i}    IN RANGE    ${scroll_count}
        Log    Scrolling iteration: ${i}
        # Ekstraksi data saat ini
        ${posts}=    Get WebElements    xpath=//article
        FOR    ${post}    IN    @{posts}
            # Ambil Username
            ${username}=    Run Keyword And Return Status    Get Text    ${post} >> xpath=.//a[contains(@href, '/@')]
            ${content}=     Run Keyword And Return Status    Get Text    ${post} >> xpath=.//div[@dir='auto']
            
            # (Fase 3) Simpan ke list jika berhasil
            # Untuk demo, kita log saja dulu kontennya
            Log    Post by User: ${username} - Content: ${content}
        END
        
        # Scroll ke bawah
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
        Sleep    3s
    END
    Return From Keyword    ${all_data}

Extract Threads Post Data
    [Documentation]    Keyword spesifik untuk mengambil teks postingan kendala UMKM.
    # Selektor Threads sering berubah, kita gunakan pattern yang umum
    ${elements}=    Get WebElements    xpath=//div[@data-pressable-container="true"]//span[@dir="auto"]
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Log    Found Text: ${text}
        # Filter kata kunci untuk memastikan relevansi
        IF    'kendala' in '${text}' or 'masalah' in '${text}' or 'sulit' in '${text}'
            Append To File    data/raw_data_umkm.txt    ${text}\n---\n
        END
    END

Close Browser Session
    Close All Browsers
