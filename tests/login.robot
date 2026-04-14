*** Settings ***

Library             String

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context
Resource            users.resource
Resource            pages/loginpage.robot

*** Variables ***

${SITE_URL}         https://authentication-6o1.pages.dev
${USERNAME}         ${JANE_USERNAME}
${PASSWORD}         ${JANE_PASSWORD}

*** Test Cases ***

Successful Login
    Open Login Page

    Fill Form       ${USERNAME}   ${PASSWORD}
    Submit Form

    Assert Text Is Visible   Successfully logged in

    Get Url         contains    dashboard

Successful Login with case insensitive email
    Open Login Page
    ${email_uppercase}=    Convert To Uppercase    ${USERNAME}
    Fill Form       ${email_uppercase}   ${PASSWORD}
    Submit Form

    Assert Text Is Visible   Successfully logged in

    Get Url         contains    dashboard

Dashboard redirects to login
    New Page        ${SITE_URL}/dashboard

    Get Url         not contains   dashboard
    Click           "You must be logged in to enter the dashboard"

Login form validates username and password
    Open Login Page

    Fill Form       foo    bar
    Submit Form

    Assert Text Is Visible      Please enter a valid email address.
    Assert Text Is Visible      Password must be at least 6 characters long.

Unknown username fails login
    Open Login Page

    Fill Form      demo@example.com   password123
    Submit Form

    Assert Text Is Visible     Invalid email or password

User is redirected to login after logging out
    Open Login Page

    Fill Form       ${USERNAME}   ${PASSWORD}
    Submit Form

    Assert Text Is Visible   Successfully logged in
    Get Url         contains    dashboard

    Click           "Logout"
    Assert Text Is Visible    You have been logged out.

