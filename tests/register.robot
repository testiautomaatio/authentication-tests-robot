*** Settings ***
Library             Browser
Library             String

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context

# The users.resource file contains usernames and passwords that can be used:
Resource            users.resource
Resource            pages/registerpage.robot


*** Variables ***

# The email address of an existing user, which should not be allowed to register again.
${EXISTING_EMAIL}   ${JANE_USERNAME}


*** Test Cases ***

Registration requires all fields to be filled
    Open Registration Page
    Submit Form

    Assert Text Is Visible    Name is required.
    Assert Text Is Visible    Please enter a valid email address.
    Assert Text Is Visible    Password must be at least 6 characters long.

Already registered email must show an error message
    Open Registration Page
    Fill Registration Form       John Doe     ${EXISTING_EMAIL}     password1
    Submit Form

    Assert Text Is Visible    Email is already in use

Registration is case insensitive
    Open Registration Page
    
    ${email_uppercase}=    Convert To Uppercase    ${EXISTING_EMAIL}
    Fill Registration Form       John Doe     ${email_uppercase}     password1
    Submit Form

    Assert Text Is Visible    Email is already in use

Successful Registration
    Open Registration Page

    # local variables can be used to store test data that is only relevant for a single test case
    VAR  ${user}  new_user@example.com
    VAR  ${pass}  Correct Horse Battery Staple

    Fill Registration Form       John Doe     ${user}     ${pass}
    Submit Form

    Assert Text Is Visible    Account created successfully
    
    Fill Login Form    ${user}    ${pass}
    Submit Form

    Assert Text Is Visible    Successfully logged in


