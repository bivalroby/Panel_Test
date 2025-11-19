*** Settings ***
Library     SeleniumLibrary
Resource    ${CURDIR}${/}../../resources/pages/ui_element_interaction.robot
Resource    ${CURDIR}${/}../../resources/pages/crm_login_page.robot
Resource    ${CURDIR}${/}../../resources/pages/organizations_page.robot
Resource    ${CURDIR}${/}../../resources/pages/contacts_main_page.robot

*** Variables ***
${search_contact}        css=input[name='search']

*** Keywords ***
Search Contacts From Contacts Page
    [Arguments]    ${text}
    Go To Contacts Main Page
    Type Text In UI Element    ${search_contact}        ${text}
    Check Table Row Has Name    ${text}
    Table Should Be Sorted By Name

Search Contacts Using Organization Name
    [Arguments]    ${text}
    Go To Contacts Main Page
    Type Text In UI Element    ${search_contact}        ${text}
    Check Table Row Has Name    ${text}
