*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    ${CURDIR}${/}../../resources/pages/popup_handler.robot
Resource    ${CURDIR}${/}../../resources/pages/ui_element_interaction.robot
Resource    ${CURDIR}${/}../../config/testenvironment.robot

*** Variables ***
${emailbox}      css=input[type='email']
${passwordbox}      css=input[type='password']

*** Keywords ***
Open Login Page
    Open Browser    ${base_url}/login   chrome
    Maximize Browser Window

Enter Username
    [Arguments]    ${username}
    Type Text In UI Element    ${emailbox}    ${username}

Enter Password
    [Arguments]    ${password}
    Type Text In UI Element    ${passwordbox}    ${password}

Login With Credentials
    [Arguments]    ${username}      ${password}
    Open Login Page
    Enter Username    ${username}
    Enter Password    ${password}
    Press Keys      ${None}     ENTER
    Sleep   10 sec
    Check and Accept Alert Popup
    Page Should Contain    Dashboard

Auto Accept Chrome Push Notifications
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_experimental_option    prefs    ${CHROME_PREFS}
    Open Browser    ${URL}    chrome    options=${options}
    Maximize Browser Window
    Log    Notifications are auto-allowed
    [Teardown]    Close Browser