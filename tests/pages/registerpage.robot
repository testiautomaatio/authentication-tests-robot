*** Settings ***

Library             Browser


*** Variables ***

${REGISTER_URL}        https://authentication-6o1.pages.dev/signUp


*** Keywords ***

Open Registration Page
    New Page        ${REGISTER_URL}

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
