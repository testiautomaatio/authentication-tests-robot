*** Settings ***

Library             Browser


*** Variables ***

${LOGIN_URL}        https://authentication-6o1.pages.dev


*** Keywords ***

Open Login Page
    New Page        ${LOGIN_URL}

Assert Text Is Visible
    [Arguments]     ${text}
    Get Element States    "${text}"    contains    visible

Fill Form
    [Arguments]     ${username}  ${password}
    Fill Text       id=email      ${username}
    Fill Text       id=password   ${password}
    

Submit Form
    ${button}=      Get Element By Role   button   name=Sign in     exact=True
    Click     ${button}

