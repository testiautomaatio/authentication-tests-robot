*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context
Resource            users.resource

#Suite Teardown      Close Browser

*** Variables ***

${SITE_URL}         https://authentication-6o1.pages.dev
${USERNAME}         ${USERNAME2}
${PASSWORD}         ${PASSWORD2}

*** Test Cases ***

Successful Login
    New Page        ${SITE_URL}

    Fill Form       ${USERNAME}   ${PASSWORD}
    Submit Form

    Assert Text Is Visible   Successfully logged in

    Get Url         contains    dashboard

Dashboard redirects to login
    New Page        ${SITE_URL}/dashboard

    Get Url         not contains   dashboard
    Click           "You must be logged in to enter the dashboard"

Login form validates username and password
    New Page        ${SITE_URL}

    Fill Form       foo    bar
    Submit Form

    Assert Text Is Visible      Please enter a valid email address.
    Assert Text Is Visible      Password must be at least 6 characters long.

Unknown username fails login
    New Page        ${SITE_URL}

    Fill Form      demo@example.com   password123
    Submit Form

    Assert Text Is Visible     Invalid email or password

User is redirected to login after logging out
    New Page        ${SITE_URL}

    Fill Form       ${USERNAME}   ${PASSWORD}
    Submit Form

    Assert Text Is Visible   Successfully logged in
    Get Url         contains    dashboard

    Click           "Logout"
    Assert Text Is Visible    You have been logged out.

*** Keywords ***

Assert Text Is Visible
    [Arguments]    ${text}
    Get Element States    "${text}"    contains    visible

Fill Form
    [Arguments]    ${username}  ${password}
    Fill Text       id=email      ${username}
    Fill Text       id=password   ${password}
    

Submit Form
    ${button}=     Get Element By Role   button   name=Sign in     exact=True
    Click     ${button}
