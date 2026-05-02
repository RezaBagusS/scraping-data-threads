*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections

*** Variables ***
${CHROME_CONFIG}    add_argument("--disable-notifications"); add_argument("--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")

*** Keywords ***
Setup Browser
    [Arguments]    ${url}    ${browser}=chrome
    Open Browser    ${url}    ${browser}    options=${CHROME_CONFIG}
    Set Selenium Speed    0.3 seconds
    Set Window Size    1280    900

Login To Threads
    [Documentation]    Melakukan login ke Threads dengan selektor yang lebih fleksibel.
    Go To    https://www.threads.net/login
    
    # Mencoba menangani berbagai kemungkinan elemen login
    Log    Mencoba mencari form login...
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains Element    css=input    timeout=20s
    
    IF    ${status}
        # Gunakan atribut yang lebih umum: name, type, atau autocomplete
        Input Text      xpath=//input[contains(@name, 'username') or @type='text']    %{THREADS_USERNAME}
        Input Password  xpath=//input[contains(@name, 'password') or @type='password']    %{THREADS_PASSWORD}
        Click Element   xpath=//button[contains(., 'Log in') or @type='submit']
    ELSE
        Capture Page Screenshot    login_failed_no_input.png
        Fail    Gagal menemukan kolom input login. Silakan cek screenshot login_failed_no_input.png
    END
    
    # Tunggu dashboard
    Sleep    5s
    Wait Until Page Contains Element    xpath=//main    timeout=30s
    Log    Login Berhasil!

Search Threads For Topic
    [Arguments]    ${keyword}
    ${encoded_keyword}=    Replace String    ${keyword}    ${SPACE}    %20
    Go To    https://www.threads.net/search?q=${encoded_keyword}
    Log    Mencari topik: ${keyword}
    Sleep    5s
    Execute Javascript    window.scrollTo(0, 500)
    Sleep    2s

Scroll Down And Collect Data
    [Arguments]    ${scroll_count}=5
    FOR    ${i}    IN RANGE    ${scroll_count}
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
        Sleep    3s
    END

Extract Threads Post Data
    [Documentation]    Keyword untuk mengambil teks postingan.
    ${elements}=    Get WebElements    xpath=//div[@data-pressable-container="true"]//span[@dir="auto"]
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Log    Found Text: ${text}
        Append To File    data/raw_data_umkm.txt    ${text}\n---\n
    END

Close Browser Session
    Close All Browsers
