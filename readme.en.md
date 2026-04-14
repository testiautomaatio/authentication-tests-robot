# First Robot Framework Tests 🤖

The purpose of this exercise is to learn how to run and write tests using [Robot Framework](https://robotframework.org/).

This assignment continues from the Playwright exercise, where login and registration were practiced using the same website under test. In this Robot Framework exercise, the focus is on the same functionality, but the goal is now to implement the tests with Robot Framework and become familiar with its features and syntax.

As before, the site used in this exercise is built for testing practice, so it does not follow all assumptions typical of production websites. In particular, registrations and logins made through the site are **valid only within the same browser session**. For example, a registration does not persist between test cases when the browser is reset at the beginning of each test case.

To get started, we recommend watching, for example, the [Robot Framework tutorial (youtube.com)](https://www.youtube.com/playlist?list=PLSK6YK5OGX1AuQy0tbvdKBV9mrKi46kKH) playlist.


## Installations

Robot Framework is a Python-based test automation framework, so using it requires Python and pip to be installed. In addition to Robot Framework, you need the Browser library, which enables controlling web browsers in your tests. The Browser library uses Playwright under the hood, and Playwright is implemented with Node.js, so Node.js must also be installed.

Detailed installation instructions and information about the ready-made devcontainer solution can be found in the separate [installations.md](./installations.md) file.


## Running tests

Once you have installed Robot Framework and the Browser library, you can try running your first tests. This repository includes a pre-defined test file [`tests/example.robot`](./tests/example.robot) that contains a simple test. You can run that test file with:

```sh
robot --outputdir=test-results/ tests/example.robot
```

The test should pass successfully and print the results to the console. Robot Framework also generates an HTML report that you can open in a browser.

Viewing the report is especially useful if tests fail, because it contains detailed information about test cases and screenshots for failed tests.


## Website under test

The target of testing is the example site https://authentication-6o1.pages.dev/, which contains a small set of features for signing in and creating user accounts. The site is intentionally simple but also designed with quality in mind, so it serves as a good first test target. For quality, for example, field labels and error messages are implemented so they are easy to identify and handle programmatically in tests.

The site is intended to be tested using a "black box" approach, meaning you are not expected to inspect the site source code or network traffic to write the tests. However, inspecting HTML structures is still necessary so you can perform the required operations on text fields and buttons.


### Registration

Registration is available at https://authentication-6o1.pages.dev/signUp. The test site also has buttons for using external services for registration, but those are not actually implemented.

Registration with this form creates a new user account that is valid only within one browser session or one test case.


### Login

Login is available at https://authentication-6o1.pages.dev/. After successful login, the user is redirected to https://authentication-6o1.pages.dev/dashboard, where a welcome message is shown. Like registration, login is also valid only within the same session.

In addition to the temporary accounts you can create yourself, the site has predefined accounts that are always valid:

| Name     | Username             | Password                           | Env variables in GitHub \*         |
|----------|----------------------|------------------------------------|------------------------------------|
| Jane Doe | jane.doe@example.com | `ItWorksOnMyMac1!`                 | `JANE_USERNAME`, `JANE_PASSWORD`   |
| John Doe | john.doe@example.com | `AllTestsPass1!`                   | `JOHN_USERNAME`, `JOHN_PASSWORD`   |
| Alice    | alice@example.com    | `}3jc\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj` | `ALICE_USERNAME`, `ALICE_PASSWORD` |
| Bob      | bob@example.com      | `nUL9zA3q=Nt7\N,0?CL&c74U,Ic)0)dN` | `BOB_USERNAME`, `BOB_PASSWORD`     |

You can use these credentials in test cases where you need login or registration with an existing user, or where you want to verify that the same account cannot be registered again.

The credentials can also be found in the [`tests/users.resource` file](./tests/users.resource), which is intended for use as a resource in test files.

\* *Read more about environment variables at the end of this document.*


## Implementing your own tests

After trying the target site manually, you can start writing your own tests. In this assignment, the goal is to write test cases for registration and login. You can write tests either in a single file or in separate files, depending on how you want to organize your test cases. Your files must follow Robot Framework test file naming conventions, meaning they must end with `.robot`. They must also be located in the `tests` folder.


## Test cases

Derive test cases from the following requirements and write tests for them. In each test case, perform appropriate actions and assertions to verify that the tested functionality works as expected. Test cases must also include typical error situations listed below.

To get started, we recommend reviewing the [Browser library](https://marketsquare.github.io/robotframework-browser/Browser.html) documentation as well as the Robot Framework [guides section](https://docs.robotframework.org/docs) and [user guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html).


### Login

1. The service home page must contain a login form with fields for email and password, and a login button
2. A registered user must be able to sign in with their email and password
    * Login must be case-insensitive for the email field, but case-sensitive for the password field
3. After successful login, the user must be redirected to `/dashboard`, where a welcome message is shown
4. Login must prevent unauthorized access
    * Both username and password are required
    * Missing or invalid values must show error messages (invalid email or password length)
    * Failed login attempts must keep the user on login page and show an error message
5. Users can't access `/dashboard` directly without a valid login session
    * they must be redirected back to the login page
    * an error message needs to be shown
6. When a logged-in user logs out using the "Logout" button, they are redirected back to the login page

### Registration

1. Registration must be accessible both directly via `/signUp` URL and through the home page "Sign up" link
2. Name, email, and password are required for registration
    * Missing or invalid values must show error messages
3. A registration attempt with an already registered email must show an error message
    * Registration is case-insensitive for the email field, so just changing the case of letters in the email should not allow registration to succeed
4. Registration with valid data must create an account
    * A success message needs to be shown
    * The user must be redirected to the login page
5. An account created during registration must be usable for login immediately afterward (within the same browser session)


### Usernames and passwords in environment variables

Writing usernames, passwords, and API keys in plain text directly in test cases is generally not recommended, because they may be accidentally exposed. In this case, the test system passwords are public, so the risk is low, but it is still useful to practice secure handling of secrets.

A better approach is to store secrets in environment variables or CI secrets. In Robot Framework, you can use environment variables with [its own syntax](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#environment-variables).

If you want, you can practice using environment variables in Robot Framework and define your local variables with the same names as those in the GitHub Actions environment.

> [!NOTE]
> To ensure variables work correctly in both your local development environment and GitHub Actions evaluation, only the following variables are supported:
>
> * `JANE_USERNAME` & `JANE_PASSWORD`
> * `JOHN_USERNAME` & `JOHN_PASSWORD`
> * `ALICE_USERNAME` & `ALICE_PASSWORD`
> * `BOB_USERNAME` & `BOB_PASSWORD`


## Automatic assessment of the assignment

Once you have written your test cases and verified they work as expected, you can submit the assignment for automatic evaluation. Add your created test files to version control and push the changes to GitHub using `git status`, `git add`, `git commit`, and `git push`. After `push`, a GitHub Actions automatic check will run the tests and provide feedback. You can view the feedback in the Actions tab of your GitHub repository.

In automatic evaluation, Chrome is used and tests are run one by one in headless mode. Before submission, we recommend verifying your tests locally with:

```bash
robot --outputdir=test-results/ tests/
```

After submission, your tests are scored based on how well they verify the requirements listed above. It is therefore important to provide both valid and invalid inputs and verify that the site state and displayed messages behave correctly. If needed, inspect the report and test results in the Actions tab to extend your tests with additional coverage. You can resubmit multiple times until the assignment deadline.


### Tracing

For **automatic evaluation**, test cases must save browser events into a "trace" file, which is used to verify that the required scenarios were executed.

To ensure trace files are saved correctly, run `New Context    tracing=True` at the beginning of each test case. The command opens a new context so tests are isolated from each other. Most importantly, `tracing=True` enables later inspection of test steps. Read more in the [Browser library documentation](https://marketsquare.github.io/robotframework-browser/Browser.html#Browser%2C%20Context%20and%20Page).

The easiest way to create a new context at the start of each test and close it at the end is to add these lines to the `*** Settings ***` section at the top of each robot file:

```robot
# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context
```

Trace files are saved in the `test-results/browser/traces` folder as zip files, which you can inspect with [Playwright Trace Viewer](https://playwright.dev/docs/trace-viewer). The tool can be used locally or at https://trace.playwright.dev/. See Playwright’s own [example trace file](https://trace.playwright.dev/?trace=https://demo.playwright.dev/reports/todomvc/data/fa874b0d59cdedec675521c21124e93161d66533.zip) and the related [example video](https://youtu.be/yP6AnTxC34s).


## Licenses

Robot Framework is licensed under the [Apache 2.0 license](https://github.com/robotframework/robotframework/blob/master/LICENSE.txt).

The Browser library is licensed under the [Apache 2.0 license](https://github.com/MarketSquare/robotframework-browser/blob/main/LICENSE).

The RobotCode extension is licensed under the [Apache 2.0 license](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode#license).


## About the material

This assignment was created by Teemu Havulinna and is licensed under [Creative Commons BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Language models and AI tools such as GitHub Copilot and ChatGPT were used in creating this assignment.
