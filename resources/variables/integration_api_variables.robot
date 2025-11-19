*** Settings ***
Resource    ${CURDIR}${/}../../config/testenvironment.robot

*** Variables ***
${HEADERS}     {"Content-Type": "application/json"}
${RETRIES}     2
${RETRY_DELAY}  2s

# Define APIs with method, endpoint, expected status, JSON Field to be validated, JSON Value to be validated and optional payload
&{API_CD_TC_001}    method=GET    endpoint=/organization/contacts?search=Atestorganization    status=200    json_field=id    json_value=1312    is_list=True
&{API_CD_TC_002}    method=GET    endpoint=/account/1    status=200    json_field=id    json_value=1    is_list=False
&{API_CD_TC_003}    method=GET    endpoint=/contact/1051    status=200    json_field=id    json_value=1051    is_list=False
&{API_CD_TC_004}    method=GET    endpoint=/organization/167    status=200    json_field=id    json_value=167    is_list=False
&{API_CD_TC_005}    method=GET    endpoint=/organizations    status=200    json_field=None    json_value=None    is_list=True
&{API_CD_TC_006}    method=GET    endpoint=/user/1    status=200    json_field=id    json_value=1    is_list=False
&{API_CD_TC_007}    method=GET    endpoint=/users    status=200    json_field=None    json_value=None    is_list=True
&{API_CD_TC_008}    method=GET    endpoint=/users?role=admin    status=200    json_field=id    json_value=1    is_list=True
&{API_CD_TC_009}    method=GET    endpoint=/organization/contacts?search=test1456    status=404    json_field=None    json_value=None    is_list=False
&{API_CD_TC_010}    method=GET    endpoint=/account/8787    status=404    json_field=None    json_value=None    is_list=False
&{API_CD_TC_011}    method=GET    endpoint=/contact/8787    status=404    json_field=None    json_value=None    is_list=False
&{API_CD_TC_012}    method=GET    endpoint=/organization/8787    status=404    json_field=None    json_value=None    is_list=False
&{API_CD_TC_013}    method=GET    endpoint=/user/8789    status=404    json_field=None    json_value=None    is_list=False

@{API_LIST}    ${API_CD_TC_001}      ${API_CD_TC_002}     ${API_CD_TC_003}    ${API_CD_TC_004}      ${API_CD_TC_005}    ${API_CD_TC_006}      ${API_CD_TC_007}     ${API_CD_TC_008}
...     ${API_CD_TC_009}      ${API_CD_TC_010}     ${API_CD_TC_011}    ${API_CD_TC_012}      ${API_CD_TC_013}

