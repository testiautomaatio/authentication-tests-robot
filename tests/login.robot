*** Settings ***
Library             Browser
# The users.resource file contains usernames and passwords that can be used:
Resource            users.resource

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Variables ***
${SITE_URL}     https://authentication-6o1.pages.dev/


*** Test Cases ***
Example Test
    Fail    This is an example test that fails. Replace this with your own test cases.
