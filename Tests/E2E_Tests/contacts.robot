*** Settings ***
Library     SeleniumLibrary
Resource    ${CURDIR}${/}../../resources/pages/update_contacts_page.robot
Resource    ${CURDIR}${/}../../resources/pages/organizations_page.robot
Resource    ${CURDIR}${/}../../testdata/contacts_test_data.robot
Resource    ${CURDIR}${/}../../testdata/organizations_test_data.robot
Resource    ${CURDIR}${/}../../resources/keywords/search_page.robot

*** Test Cases ***
UI_CD_TC_001_Add_Contact_From_Contacts_Page
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Create Contact        ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}
    ...                  ${CONTACT_EMAIL}    ${CONTACT_PHONE}    ${CONTACT_ADDRESS}
    ...                  ${CONTACT_CITY}     ${CONTACT_STATE}       ${CONTACT_POSTAL}
    [Teardown]      Close All Browsers

UI_CD_TC_003_Contacts_Appear_Naturally_Within_Organization_Workflow
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Open Organization Page   ${ORGANIZATION_NAME}       ${CONTACT_ORGANIZATION_ID}
    Validate Contact In Organization     ${CONTACT_FIRST}   ${CONTACT_LAST}
    [Teardown]      Close All Browsers

UI_CD_TC_004_View_An_Individual_Contact_Within_Organization_Context
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Open Organization Page   ${ORGANIZATION_NAME}       ${CONTACT_ORGANIZATION_ID}
    Open Contact In Organization     ${CONTACT_FIRST}   ${CONTACT_LAST}
    [Teardown]      Close All Browsers

UI_CD_TC_005_Update_Existing_Contact_From_Contacts_Page
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Search Contacts From Contacts Page      ${CONTACT_FIRST}
    Open Contact In Contact Page        ${CONTACT_FIRST}    ${CONTACT_LAST}
    Update Contact Details       ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}    address=${UPDATE_ADDRESS}
    [Teardown]      Close All Browsers

UI_CD_TC_006_Update_Existing_Contact_from_organisation page
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Open Organization Page   ${ORGANIZATION_NAME}       ${CONTACT_ORGANIZATION_ID}
    Open Contact In Organization     ${CONTACT_FIRST}   ${CONTACT_LAST}
    Update Contact Details       ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}    address=${UPDATE_ADDRESS}
    [Teardown]      Close All Browsers

UI_CD_TC_007_Delete_Contact_from_Contacts_page
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Run Keyword And Ignore Error    Create Contact        ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}
    ...                  ${CONTACT_EMAIL}    ${CONTACT_PHONE}    ${CONTACT_ADDRESS}
    ...                  ${CONTACT_CITY}     ${CONTACT_STATE}       ${CONTACT_POSTAL}
    Open Organization Page   ${ORGANIZATION_NAME}       ${CONTACT_ORGANIZATION_ID}
    Open Contact In Organization     ${CONTACT_FIRST}   ${CONTACT_LAST}
    Delete Contact Details
    [Teardown]      Close All Browsers

UI_CD_TC_008_Delete_Contact_from_Organization_page
    [Tags]      Happy Flows
    [Setup]     Login With Credentials    ${username}    ${password}
    Run Keyword And Ignore Error     Create Contact        ${CONTACT_FIRST}    ${CONTACT_LAST}    ${CONTACT_ORGANIZATION_ID}    ${CONTACT_COUNTRY}
    ...                  ${CONTACT_EMAIL}    ${CONTACT_PHONE}    ${CONTACT_ADDRESS}
    ...                  ${CONTACT_CITY}     ${CONTACT_STATE}       ${CONTACT_POSTAL}
    Open Organization Page   ${ORGANIZATION_NAME}       ${CONTACT_ORGANIZATION_ID}
    Open Contact In Organization     ${CONTACT_FIRST}   ${CONTACT_LAST}
    Delete Contact Details
    [Teardown]      Close All Browsers