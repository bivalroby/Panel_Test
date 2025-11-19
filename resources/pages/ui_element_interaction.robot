*** Settings ***
Library     SeleniumLibrary
Library    Collections

*** Keywords ***
Click UI Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Type Text In UI Element
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${text}

Select From List Element
    [Arguments]    ${locator}    ${value}
    Wait Until Element Is Visible    ${locator}
    Select From List By Value    ${locator}    ${value}

Element Should Contain Value
    [Arguments]    ${locator}    ${expectedmessage}
    Wait Until Element Is Visible    ${locator}
    Element Should Contain      ${locator}      ${expectedmessage}

Click Table Row By Name
    [Arguments]    ${name}
    Click UI Element    xpath=//table//tr[td//a[contains(normalize-space(.), '${name}')]]//a

Table Should Be Sorted By Name
    ${names}=    Get WebElements    xpath=//table//tr/td[1]/a
    @{name_list}=    Create List
    FOR    ${item}    IN    @{names}
        ${text}=    Get Text    ${item}
        Append To List    ${name_list}    ${text}
    END
    ${sorted_list}=    Copy List    ${name_list}
    Sort List    ${sorted_list}
    Lists Should Be Equal    ${name_list}    ${sorted_list}

Check Table Row Has Name
    [Arguments]    ${name}
    Sleep   10 sec
    Element Should Be Visible    xpath=//table//tr[td//a[contains(normalize-space(.), '${name}')]]//a