"""
Secret variables are used to store sensitive information, such as passwords, in a way that
prevents them from being exposed in logs or reports. In Robot Framework, you can use the
`Secret` class to define secret variables.

Note that the variables being secret does not mean that they are encrypted or completely secure.
It only means that they will not be printed in the Robot Framework's logs or reports.
External tools, such as the Browser Library and Playwright, can still log these in plain text
in their logs and traces.

Read more about secret variables in the Robot Framework User Guide:

https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#secret-variables
"""

from robot.api.types import Secret

JANE_USERNAME = Secret("jane.doe@example.com")
JANE_PASSWORD = Secret("ItWorksOnMyMac1!")

JOHN_USERNAME = Secret("john.doe@example.com")
JOHN_PASSWORD = Secret("AllTestsPass1!")

ALICE_USERNAME = Secret("alice@example.com")
ALICE_PASSWORD = Secret(r"3jc\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj")

BOB_USERNAME = Secret("bob@example.com")
BOB_PASSWORD = Secret(r"nUL9zA3q=Nt7\N,0?CL&c74U,Ic)0)dN")
