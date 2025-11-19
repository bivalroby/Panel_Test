*** Settings ***
Library     SeleniumLibrary
Resource    ${CURDIR}${/}../../resources/pages/ui_element_interaction.robot
Resource    ${CURDIR}${/}../../resources/pages/crm_login_page.robot

*** Variables ***
${contact_title}            xpath =/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/h1
${create_button}            css=input[class='btn-indigo']

*** Keywords ***
Go To Contacts Main Page
    Go To    ${BASE_URL}/contacts
    Sleep    10 sec
    Page Should Contain    Contacts

Click Create Contact
    Click UI Element    ${create_button}

Open Contact In Contact Page
    [Arguments]     ${contact_first_name}       ${contact_last_name}
    ${contact_full_name}    Set Variable        ${contact_first_name} ${contact_last_name}
    Click Table Row By Name     ${contact_first_name}
    Wait Until Page Contains        ${contact_full_name} - Ping CRM

Open Contact
    [Arguments]     ${contact_full_name}
    Click UI Element    xpath=//a[text()= ${contact_full_name}
    Wait Until Element Is Visible       ${contact_title}

Check Contact In Contacts Main Page
    [Arguments]     ${contact_full_name}
    Click UI Element    xpath=//a[text()= ${contact_full_name}
    Wait Until Element Is Visible       ${contact_title}


