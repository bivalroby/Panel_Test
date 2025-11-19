*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    OperatingSystem
Library    BuiltIn
Library    String
Library    DateTime
Resource    ${CURDIR}${/}../../resources/variables/integration_api_variables.robot
*** Keywords ***
Create API Session
    [Arguments]    ${base_url}    ${headers}
    Create Session    api_session    ${base_url}    headers=${headers}

Validate Response Status
    [Arguments]    ${response}    ${expected_status}    ${endpoint}=${EMPTY}
    Run Keyword If    ${response.status_code} != ${expected_status}    Fail    API ${endpoint} returned ${response.status_code}, expected ${expected_status}

Log API Response
    [Arguments]    ${response}    ${endpoint}=${EMPTY}
    Log    Response for ${endpoint}: ${response.text}

Validate JSON Response
    [Arguments]    ${response}    ${json_field}    ${json_value}    ${is_list}=False    ${endpoint}=${EMPTY}
    IF  '${is_list}'=='True'
        Validate List Response    ${response}    ${json_field}    ${json_value}    ${endpoint}
    ELSE
        Validate Single Response    ${response}    ${json_field}    ${json_value}    ${endpoint}
    END

Validate List Response
    [Arguments]    ${data}    ${json_field}    ${json_value}    ${endpoint}
    Should Be True    ${data} != []    msg=API ${endpoint} returned empty list
    FOR     ${item}   IN     @{data}[data]
        JSON Item Matches   ${item}    ${json_field}    ${json_value}
    END

Validate Single Response
    [Arguments]    ${data}    ${json_field}    ${json_value}    ${endpoint}
    JSON Item Matches   ${data}[data]    ${json_field}    ${json_value}

JSON Item Matches
    [Arguments]    ${item}    ${json_field}    ${json_value}
    ${has_field}=    Evaluate    '${json_field}' in ${item}
    ${has_value}    Set Variable If    ${item["${json_field}"]}==${json_value}      ${True}
    IF    ${has_field} and ${has_value}
        RETURN    True
    END
    RETURN    False

Send Rest Request
    [Documentation]    This keyword performs a GET/POST/PUT/DELETE request and return response json and response
    [Arguments]    ${method}    @{args}    &{kw_args}
    ${request_method}    Convert To Upper Case    ${method}
    ${response}    Run Keyword If    "GET" == $request_method    GET    @{args}    &{kw_args}
    ...    ELSE IF    "POST" == $request_method     POST    @{args}    &{kw_args}
    ...    ELSE IF    "DELETE" == $request_method     DELETE    @{args}    &{kw_args}
    ...    ELSE IF    "PUT" == $request_method     PUT    @{args}    &{kw_args}
    ...    ELSE    Fail    msg=Provide a valid request method
    Log To Console      actualresponsecode:${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    ${kw_args['expected_status']}
    Run Keyword And Ignore Error    Log     ${response.json()}
    Log To Console      Expectedresponse:${kw_args['expected_status']}
    [Return]    ${response}

Send Rest Request With Retry
    [Documentation]    This keyword performs a GET/POST/PUT/DELETE request and return response json and response
    [Arguments]    ${method}    @{args}    &{kw_args}
    ${attempt}    Set Variable    0
    FOR    ${count}    IN RANGE    ${RETRIES}+1
        ${start}    Get Time    epoch
        ${response}     Send Rest Request     ${method}      @{args}    &{kw_args}
        ${end}    Get Time      epoch
        ${duration}    Evaluate    ${end} - ${start}
        Log    API ${kw_args['url']} duration: ${duration} seconds        console=True
        ${res_code}      Convert To Integer      ${response.status_code}
        ${exp_code}      Convert To Integer      ${kw_args['expected_status']}
        Return From Keyword If     ${res_code}==${exp_code}      Return From Keyword    ${response}
        Log    Attempt ${count} failed for ${kw_args['url']}, retrying after ${RETRY_DELAY}     console=true
        Sleep    ${RETRY_DELAY}
    END
    Fail    API ${kw_args['url']} failed after ${retries} retries
