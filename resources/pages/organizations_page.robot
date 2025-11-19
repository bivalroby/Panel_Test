*** Settings ***
Resource    ${CURDIR}${/}../../resources/pages/crm_login_page.robot
Resource    ui_element_interaction.robot
Library    SeleniumLibrary

*** Variables ***
${ORG_ROW_FIRST}         css=.organization-row:first-child
${CONTACT_ROW_FIRST}     css=.contact-row:first-child
${search_org}         xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div[1]/div/div/input

*** Keywords ***
Go To Organizations Page
    Go To    ${BASE_URL}/organizations
    Wait Until Page Contains     Organizations

Open First Organization
    Click UI Element    ${ORG_ROW_FIRST}

Open Organization Page
    [Arguments]     ${org_name}     ${org_id}
    ${hreference}   Set Variable    "/organizations/${org_id}/edit"
    Go To Organizations Page
    Type Text In UI Element        ${search_org}        ${org_name}
    Wait Until Page Contains     ${org_name}
    Click UI Element   xpath=//a[@href=${hreference} and contains(., ${org_name} )]
    Wait Until Page Contains        ${org_name} - Ping CRM

Open Contact In Organization
    [Arguments]     ${contact_first_name}       ${contact_last_name}
    ${contact_full_name}    Set Variable        ${contact_first_name} ${contact_last_name}
    Click Table Row By Name     ${contact_full_name}
    Wait Until Page Contains        ${contact_full_name} - Ping CRM

Validate Contact In Organization
    [Arguments]     ${contact_first_name}       ${contact_last_name}
    ${contact_full_name}    Set Variable        ${contact_first_name} ${contact_last_name}
    Wait Until Page Contains        ${contact_last_name}
