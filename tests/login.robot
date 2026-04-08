*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context

# The users.resource file contains usernames and passwords that can be used:
Resource            users.resource


*** Variables ***

${SITE_URL}         https://authentication-6o1.pages.dev/
${USERNAME}         alice@example.com
${PASSWORD}         }3jc\\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj

*** Test Cases ***

Successful Login
    New Page        ${SITE_URL}

    Fill Text       id=email       ${USERNAME}
    Fill Text       id=password    ${PASSWORD}

    Submit Form
    Assert Text Is Visible   "Welcome Alice!"

    Get Url        contains    dashboard



*** Keywords ***

Assert Text Is Visible
    [Arguments]    ${text}
    Get Element States    ${text}    contains    visible

Submit Form
    ${button}=     Get Element By Role   button   name=Sign in     exact=True
    Click     ${button}
