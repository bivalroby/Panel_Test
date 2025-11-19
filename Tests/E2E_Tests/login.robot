*** Settings ***
Resource    ${CURDIR}${/}../../resources/pages/crm_login_page.robot
Resource    ${CURDIR}${/}../../testdata/login_test_data.robot

*** Test Cases ***
UI_LG_TC_001_User_Successful_Login
    Login With Credentials    ${username}    ${password}
    [Teardown]      Close All Browsers

UI_LG_TC_002_Login With Invalid Credentials
    [Setup]     Open Login Page
    Login With Credentials    ${invalidusername}    ${invalidpassword}
    Sleep   10 sec
    Should See Login Error    These credentials do not match our records.
    [Teardown]      Close All Browsers
