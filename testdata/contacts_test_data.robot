*** Settings ***
Resource    login_test_data.robot

*** Variables ***
${CONTACT_FIRST}    TestFirstName
${CONTACT_LAST}     TestLastName
${CONTACT_ORGANIZATION}   Atestorganization
${CONTACT_ORGANIZATION_ID}   167
${CONTACT_EMAIL}    testfirstlastname@example.com
${CONTACT_PHONE}    06578357878
${CONTACT_ADDRESS}   562 Main
${CONTACT_CITY}     Boston
${CONTACT_STATE}    MA
${CONTACT_COUNTRY}   US
${CONTACT_POSTAL}   56777

${DUPLICATE_EMAIL}   testfirst@example.com
${PARTIAL_NAME}     TestFirst
${PARTIAL_PHONE}    57878
${PARTIAL_EMAIL}    firstlast
${UPDATE_ADDRESS}   5882 street