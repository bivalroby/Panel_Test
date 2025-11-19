*** Settings ***
Library     SeleniumLibrary

Resource    ${CURDIR}${/}../../resources/pages/update_contacts_page.robot
Resource    ${CURDIR}${/}../../resources/pages/organizations_page.robot
Resource    ${CURDIR}${/}../../testdata/contacts_test_data.robot
Resource    ${CURDIR}${/}../../testdata/organizations_test_data.robot
Resource    ${CURDIR}${/}../../resources/keywords/search_page.robot

*** Test Cases ***
UI_CD_TC_009_Search_Contacts_By_Contact_Name
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Run Keyword And Ignore Error    Create Contact        ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}
    ...                  ${CONTACT_EMAIL}    ${CONTACT_PHONE}    ${CONTACT_ADDRESS}
    ...                  ${CONTACT_CITY}     ${CONTACT_STATE}       ${CONTACT_POSTAL}

    Search Contacts From Contacts Page    ${CONTACT_FIRST}
    Sleep   10 sec
    [Teardown]      Close All Browsers

UI_CD_TC_010_Search_Contacts_By_Organization_Name
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Run Keyword And Ignore Error    Create Contact        ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}
    ...                  ${CONTACT_EMAIL}    ${CONTACT_PHONE}    ${CONTACT_ADDRESS}
    ...                  ${CONTACT_CITY}     ${CONTACT_STATE}       ${CONTACT_POSTAL}

    Search Contacts Using Organization Name    ${ORGANIZATION_NAME}
    Sleep   10 sec
    [Teardown]      Close All Browsers

UI_CD_TC_018_Search_Contacts_By_Email
    Log     Login with credentials
    Log     Search contacts using partial email

UI_CD_TC_019_Search_Contacts_By_Contact_Number
    Log     Login with credentials
    Log     Search contacts using partial phone number