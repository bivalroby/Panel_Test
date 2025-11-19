*** Settings ***
Library           RequestsLibrary
Resource          ${CURDIR}${/}../../resources/keywords/integration_api_keywords.robot
Resource          ${CURDIR}${/}../../resources/variables/integration_api_variables.robot
#Suite Setup       Create API Session    ${BASE_URL}    ${HEADERS}
 
*** Test Cases ***
Run Contacts API Integration Tests
    [Tags]      Integration Tests
    FOR    ${api}    IN    @{API_LIST}
        ${method}      Set Variable    ${api['method']}
        ${endpoint}    Set Variable    ${api['endpoint']}
        ${status}      Set Variable    ${api['status']}
        ${field}       Set Variable    ${api['json_field']}
        ${value}       Set Variable    ${api['json_value']}
        ${is_list}     Set Variable    ${api['is_list']}
        ${complete_endpoint}    Set Variable    ${api_url}${endpoint}
        &{request_headers}    Create Dictionary  Content=${HEADERS}
        ...     Accept=${HEADERS}
        ${response}    Send Rest Request    ${method}    url=${complete_endpoint}
        ...     expected_status=${status}   headers=&{request_headers}
        Validate Response Status    ${response}    ${status}    ${endpoint}
        IF  ${field}!=None
            Validate JSON Response    ${response.json()}    ${field}    ${value}    ${is_list}    ${endpoint}
        END
    END

Run Contacts API Integration Tests With Retry
    FOR    ${api}    IN    @{API_LIST}
        ${method}      Set Variable    ${api['method']}
        ${endpoint}    Set Variable    ${api['endpoint']}
        ${status}      Set Variable    ${api['status']}
        ${field}       Set Variable    ${api['json_field']}
        ${value}       Set Variable    ${api['json_value']}
        ${is_list}     Set Variable    ${api['is_list']}
        ${complete_endpoint}    Set Variable    ${api_url}${endpoint}
        Log To Console      ${complete_endpoint}
        &{request_headers}    Create Dictionary  Content=${HEADERS}
        ...     Accept=${HEADERS}
        ${response}    Send Rest Request With Retry    ${method}    url=${complete_endpoint}
        ...     expected_status=${status}   headers=&{request_headers}
        #Log To Console      ${response.json()}
        Validate Response Status    ${response}    ${status}    ${endpoint}
        IF  ${field}!=None
            Validate JSON Response    ${response.json()}    ${field}    ${value}    ${is_list}    ${endpoint}
        END
    END