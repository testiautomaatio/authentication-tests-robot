*** Comments ***

The passwords of the users contain special characters, which may cause issues
...    when writing them into source files. The passwords below have the
...    backslashes escaped (\ => \\), so that Robot treats them as literal
...    characters instead of escape sequences.


*** Variables ***

${JANE_USERNAME}      jane.doe@example.com
${JANE_PASSWORD}      ItWorksOnMyMac1!

${JOHN_USERNAME}      john.doe@example.com
${JOHN_PASSWORD}      AllTestsPass1!

${ALICE_USERNAME}     alice@example.com
${ALICE_PASSWORD}     }3jc\\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj

${BOB_USERNAME}       bob@example.com
${BOB_PASSWORD}       nUL9zA3q=Nt7\\N,0?CL&c74U,Ic)0)dN
