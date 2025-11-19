*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Check and Accept Alert Popup
    Run Keyword And Ignore Error      Handle Alert    ACCEPT

Check and Reject Alert Popup
    Run Keyword And Ignore Error      Handle Alert    REJECT
