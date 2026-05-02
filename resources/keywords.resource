*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${CHROME_OPTIONS}    add_argument("--disable-notifications"); add_argument("--start-maximized")

*** Keywords ***
Setup Browser
    [Arguments]    ${url}    ${browser}=chrome
    # SeleniumLibrary sekarang mendukung auto-download driver di versi terbaru
    Open Browser    ${url}    ${browser}    options=${CHROME_OPTIONS}
    Set Selenium Speed    0.5 seconds
    Set Window Size    1280    800

Close Browser Session
    Close All Browsers
