*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context

# The users.resource file contains usernames and passwords that can be used:
Resource            users.resource


*** Variables ***

${SITE_URL}         https://authentication-6o1.pages.dev/signUp
${EXISTING_EMAIL}   ${USER1_USERNAME}

*** Test Cases ***

Registration requires all fields to be filled
    New Page        ${SITE_URL}
    Submit Form

    Assert Text Is Visible    Name is required.
    Assert Text Is Visible    Please enter a valid email address.
    Assert Text Is Visible    Password must be at least 6 characters long.

Already registered email must show an error message
    New Page        ${SITE_URL}
    Fill Registration Form       John Doe     ${EXISTING_EMAIL}     password1
    Submit Form

    Assert Text Is Visible    Email is already in use

Successful Registration
    New Page        ${SITE_URL}
    VAR  ${user}  new_user@example.com
    VAR  ${pass}  Correct Horse Battery Staple

    Fill Registration Form       John Doe     ${user}     ${pass}
    Submit Form

    Assert Text Is Visible    Account created successfully
    
    Fill Login Form    ${user}    ${pass}
    Submit Form

    Assert Text Is Visible    Successfully logged in


*** Keywords ***

Submit Form
    Click    form button[type=submit]

Assert Text Is Visible
    [Arguments]    ${text}
    Click    "${text}"

Fill Registration Form
    [Arguments]    ${name}  ${email}  ${password}
    Fill Text    id=name        ${name}
    Fill Text    id=email       ${email}
    Fill Text    id=password    ${password}

Fill Login Form
    [Arguments]    ${username}  ${password}
    Fill Text       id=email      ${username}
    Fill Text       id=password   ${password}
