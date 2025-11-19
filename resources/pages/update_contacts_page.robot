*** Settings ***
Resource    ${CURDIR}${/}../../resources/pages/contacts_main_page.robot

*** Variables ***
${firstNameInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[1]/input
${lastNameInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[2]/input
${emailInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[4]/input
${phoneInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[5]/input
${addressInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[6]/input
${cityInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[7]/input
${stateInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[8]/input
${countryInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[9]/select
${postCodeInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[10]/input
${organizationInput}            xpath=/html/body/div/div/div[2]/div/div[2]/div[2]/div[2]/div/form/div[1]/div[3]/select
${create_button}            css=button[type='submit']
${delete_button}            xpath=//button[text()='Delete Contact']

*** Keywords ***
Open Create Contact Page
    Go To Contacts Main Page
    Go To    ${BASE_URL}/contacts/create
    Sleep   10 sec

Fill Contact Form
    [Arguments]    ${first}    ${last}    ${org}   ${country}    ${email}=None    ${phone}=None
    ...            ${address}=None    ${city}=None    ${state}=None        ${postal}=None

    Run Keyword If    '${first}' != 'None'        Type Text In UI Element    ${firstNameInput}    ${first}
    Run Keyword If    '${last}' != 'None'         Type Text In UI Element    ${lastNameInput}     ${last}
    Run Keyword If    '${org}' != 'None'          Select From List Element   ${organizationInput}    ${org}
    Run Keyword If    '${email}' != 'None'        Type Text In UI Element    ${emailInput}     ${email}
    Run Keyword If    '${phone}' != 'None'        Type Text In UI Element    ${phoneInput}     ${phone}
    Run Keyword If    '${address}' != 'None'      Type Text In UI Element    ${addressInput}   ${address}
    Run Keyword If    '${city}' != 'None'         Type Text In UI Element    ${cityInput}     ${city}
    Run Keyword If    '${state}' != 'None'        Type Text In UI Element    ${stateInput}    ${state}
    Run Keyword If    '${country}' != 'None'      Select From List Element    ${countryInput}   ${country}
    Run Keyword If    '${postal}' != 'None'       Type Text In UI Element    ${postCodeInput}    ${postal}

Save Contact
    Click UI Element    ${create_button}
    Wait Until Page Contains     Contact created
    Log     Contact Created successfully

Update Contact
    Click UI Element    ${create_button}
    Wait Until Page Contains     Contact updated
    Log     Contact updated successfully

Validate Contact Details
    [Arguments]    ${first}    ${last}    ${org}   ${country}    ${email}=None    ${phone}=None
    ...            ${address}=None    ${city}=None    ${state}=None        ${postal}=None

    Run Keyword If    '${first}' != 'None'        Element Should Contain Value    ${firstNameInput}    ${first}
    Run Keyword If    '${last}' != 'None'         Element Should Contain Value    ${lastNameInput}     ${last}
    Run Keyword If    '${org}' != 'None'          Element Should Contain Value      ${organizationInput}    ${org}
    Run Keyword If    '${email}' != 'None'        Element Should Contain Value      ${emailInput}     ${email}
    Run Keyword If    '${phone}' != 'None'        Element Should Contain Value      ${phoneInput}     ${phone}
    Run Keyword If    '${address}' != 'None'      Element Should Contain Value    ${addressInput}   ${address}
    Run Keyword If    '${city}' != 'None'         Element Should Contain Value    ${cityInput}     ${city}
    Run Keyword If    '${state}' != 'None'        Element Should Contain Value    ${stateInput}    ${state}
    Run Keyword If    '${country}' != 'None'      Element Should Contain Value    ${countryInput}   ${country}
    Run Keyword If    '${postal}' != 'None'       Element Should Contain Value    ${postCodeInput}    ${postal}
    Log     Contact validated successfully


Update Contact Details
    [Arguments]    ${first}    ${last}    ${org}   ${country}    ${email}=None    ${phone}=None
    ...            ${address}=None    ${city}=None    ${state}=None        ${postal}=None
    Fill Contact Form       ${first}    ${last}    ${org}   ${country}    ${email}    ${phone}
    ...            ${address}     ${city}    ${state}        ${postal}
    Update Contact

Delete Contact Details
    Click UI Element    ${delete_button}
    Check and Accept Alert Popup
    Wait Until Page Contains     This contact has been deleted
    Log     Contact deleted successfully

Create Contact
    [Arguments]    ${first}    ${last}    ${org}   ${country}    ${email}=None    ${phone}=None
    ...            ${address}=None    ${city}=None    ${state}=None        ${postal}=None
    Open Create Contact Page
    Fill Contact Form    ${first}    ${last}    ${org}    ${country}
    ...                  ${email}    ${phone}    ${address}
    ...                  ${city}     ${state}       ${postal}
    Save Contact