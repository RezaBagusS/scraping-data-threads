*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections

*** Variables ***
# Kita definisikan string options langsung di sini
${CHROME_CONFIG}    add_argument("--disable-notifications"); add_argument("--user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")

*** Keywords ***
Setup Browser
    [Arguments]    ${url}    ${browser}=chrome
    # Langsung menggunakan string options di Open Browser (Cara paling stabil di SeleniumLibrary)
    Open Browser    ${url}    ${browser}    options=${CHROME_CONFIG}
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
    Execute Javascript    window.scrollTo(0, 500)
    Sleep    2s

Scroll Down And Collect Data
    [Arguments]    ${scroll_count}=5
    ${all_data}=    Create List
    FOR    ${i}    IN RANGE    ${scroll_count}
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
        Sleep    3s
    END
    Return From Keyword    ${all_data}

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
